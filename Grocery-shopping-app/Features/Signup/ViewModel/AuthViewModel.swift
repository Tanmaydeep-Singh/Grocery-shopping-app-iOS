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

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?
    @Published var isError: Bool = false
    @Published var errorMessage: String?

    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()

    init() {}

    
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
            self.isError = true
            self.errorMessage = error.localizedDescription
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
}
