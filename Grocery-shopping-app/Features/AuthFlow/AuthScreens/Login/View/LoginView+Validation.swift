//
//  LoginView+Validation.swift
//  Nectar
//
//  Created by tanmaydeep on 17/02/26.
//

import SwiftUI

extension LoginView {

     var emailError: String? {
        guard emailTouched else { return nil }

        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Email cannot be empty."
        }

        if !authViewModel.isValidEmail(email) {
            return "Please enter a valid email address."
        }

        return nil
    }

     var passwordError: String? {
        guard passwordTouched else { return nil }

        if password.isEmpty {
            return "Password cannot be empty."
        }

        if !authViewModel.isValidPassword(password) {
            return "Minimum 8 characters & 1 special character required."
        }

        return nil
    }

     var isFormInvalid: Bool {
        emailError != nil ||
        passwordError != nil
    }

     func handleLogin() {

        guard !isFormInvalid else { return }

        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)

        Task {
            let success = await authViewModel.loginUser(
                email: trimmedEmail,
                password: password
            )
            if success {
                path = NavigationPath()
            }
        }
    }

     func handlePasswordReset() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)

        guard !trimmedEmail.isEmpty else {
            authViewModel.errorMessage = "Email should be present"
            authViewModel.isError = true
            return
        }

        Task {
            do {
                try await authViewModel.resetPassword(email: trimmedEmail)
                showResetSuccessAlert = true
            } catch {
                authViewModel.errorMessage = error.localizedDescription
                authViewModel.isError = true
            }
        }
    }
}
