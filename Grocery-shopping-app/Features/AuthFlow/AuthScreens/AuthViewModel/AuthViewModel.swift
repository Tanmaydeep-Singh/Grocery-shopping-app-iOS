//
//  SignupViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Combine

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?
    @Published var isError: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    private let cartService: CartServices
    private let cartProductsService : CartProductsService
    private let syncCartOnLoginHelper:SyncCartOnLoginHelper
    init() {
        self.userSession = auth.currentUser
        self.cartService = CartServices()
        self.cartProductsService = CartProductsService()
        self.syncCartOnLoginHelper = SyncCartOnLoginHelper()
        
        if let currentUser = auth.currentUser {
            Task {
                await fetchUser(uid: currentUser.uid)
            }
        }
    }
    
    // MARK: - Validation

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex =
        "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex =
        "^(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }


//    Signup
    func createUser(email: String, password: String, username: String) async -> Bool {
        resetError()
        isLoading = true
        defer { isLoading = false }
        
        do {
            let authResult = try await auth.createUser(withEmail: email, password: password)
            let firebaseUser = authResult.user
            
            let user = RegisterUserRequest(
                clientName: username,
                clientEmail: email
            )

            let registerUserService = RegisterUserService()
            let token = try await registerUserService.registerUser(body: user)

            //Creating Cart
            let cart  = try await cartService.createCart()
            
            
            let newUser = User(
                id: firebaseUser.uid,
                email: email,
                username: username,
                token: token.accessToken,
                cartId: cart.cartId
            )

            try await storeUserInFirestore(user: newUser)
            self.userSession = firebaseUser
            self.user = newUser
            return true
        } catch {
            handleAuthError(error)
            return false
        }
    }

//    Login
    func loginUser(email: String, password: String) async -> Bool {
        resetError()
        isLoading = true
        defer { isLoading = false }
        
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            self.userSession = authResult.user
            await fetchUser(uid: authResult.user.uid)
                
           await syncCartOnLoginHelper.getCartItems(cartId: user!.cartId ?? "")
           
            return true
        } catch {
            handleAuthError(error)
            return false
        }
    }
    
    // Forget pass
        func resetPassword(email: String) async throws {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
            } catch {
                throw error
            }
        }

    // Google SignIn
    func signInWithGoogle() {
        resetError()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            setError("Firebase configuration error.")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            setError("Unable to find root view controller.")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            guard let self = self else { return }


            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Task {
                await self.signInToFirebaseWithGoogle(credential: credential, googleUser: user)
            }
        }
    }

    private func signInToFirebaseWithGoogle(credential: AuthCredential, googleUser: GIDGoogleUser) async {
        do {
            let authResult = try await auth.signIn(with: credential)
            let firebaseUser = authResult.user
            self.userSession = firebaseUser
            
            let doc = try await firestore.collection("users").document(firebaseUser.uid).getDocument()
            
            if doc.exists {
                await fetchUser(uid: firebaseUser.uid)
            } else {
                
            
                let user = RegisterUserRequest(
                    clientName: firebaseUser.displayName ?? "New User",
                    clientEmail: firebaseUser.email ?? ""
                )

                let registerUserService = RegisterUserService()

                let token = try await registerUserService.registerUser(body: user)
                
                //Creating Cart
                let cart  = try await cartService.createCart()
                

                
                let newUser = User(
                    id: firebaseUser.uid,
                    email: firebaseUser.email ?? "",
                    username: firebaseUser.displayName ?? "New User",
                    token: token.accessToken,
                    cartId: cart.cartId
                )
                try await storeUserInFirestore(user: newUser)
                self.user = newUser
            }
        } catch {
            handleAuthError(error)
        }
    }

// Save user to firestore
    private func storeUserInFirestore(user: User) async throws {
        try firestore
            .collection("users")
            .document(user.id)
            .setData(from: user)
    }

//    Get user from firebase
    private func fetchUser(uid: String) async {
        do {
            self.user = try await firestore
                .collection("users")
                .document(uid)
                .getDocument(as: User.self)
            
        } catch {
            print("DEBUG: Failed to fetch user: \(error.localizedDescription)")
        }
    }

    func logout() {
        try? auth.signOut()
        self.userSession = nil
        self.user = nil
        cartProductsService.clearCart()
    }

    private func handleAuthError(_ error: Error) {
        self.isError = true
        self.errorMessage = error.localizedDescription
    }

    private func setError(_ message: String) {
        self.isError = true
        self.errorMessage = message
    }
    
    private func resetError() {
        self.isError = false
        self.errorMessage = nil
    }
}
