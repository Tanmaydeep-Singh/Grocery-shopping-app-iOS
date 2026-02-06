//
//  SignupViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine
import GoogleSignIn
import FirebaseCore


@MainActor
final class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?
    @Published var isError: Bool = false
    @Published var errorMessage: String?

    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()

    init() {
    
            if let currentUser = auth.currentUser {
                self.userSession = currentUser
                Task {
                    await fetchUser(uid: currentUser.uid)
                }
            }
        }
    
//    Create User
    func createUser(
        email: String,
        password: String,
        username: String
    ) async {

        do {
            let authResult = try await auth.createUser(
                withEmail: email,
                password: password
            )

            let firebaseUser = authResult.user
            self.userSession = firebaseUser

            let newUser = User(
                id: firebaseUser.uid,
                email: email,
                username: username
            )

            await storeUserInFirestore(user: newUser)
            self.user = newUser

        } catch {
            
//            Setting error
            setError(error)
            return

        }
    }
    
//    Save User

    private func storeUserInFirestore(user: User) async {
        do {
            try firestore
                .collection("users")
                .document(user.id)
                .setData(from: user)
        } catch {
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    // User Login
    func loginUser(
        email: String,
        password: String
    ) async {

        do {
            let authResult = try await auth.signIn(
                withEmail: email,
                password: password
            )

            let firebaseUser = authResult.user
            self.userSession = firebaseUser

            await fetchUser(uid: firebaseUser.uid)

        } catch {
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }

    // Get User
    private func fetchUser(uid: String) async {
        do {
            let document = try await firestore
                .collection("users")
                .document(uid)
                .getDocument()

            self.user = try document.data(as: User.self)

        } catch {
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Logout:
    func logout() async {
        self.user = nil;
        self.userSession = nil;
        try? await auth.signOut()
    }
    
    
    // Google SignIn
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("DEBUG: Firebase Client ID not found")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("DEBUG: Could not find rootViewController")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("DEBUG: Google Sign-In Error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("DEBUG: Firebase Auth Error: \(error.localizedDescription)")
                    return
                }
                
                guard let result = authResult else { return }
                let firebaseUser = result.user
                
                self.userSession = firebaseUser
                
                let newUser = User(
                    id: firebaseUser.uid,
                    email: firebaseUser.email ?? "",
                    username: firebaseUser.displayName ?? "New User"
                )
                
                Task {
                    await self.storeUserInFirestore(user: newUser)
                    await self.fetchUser(uid: firebaseUser.uid)
                    print("DEBUG: Successfully logged in and stored user: \(newUser.username)")
                }
            }
        }
    }
    
    
    // Helper func to handle errors
    private func setError(_ error: Error) {
        self.isError = true
        self.errorMessage = error.localizedDescription
    }

}
