//
//  SignupView+Validation.swift .swift
//  Nectar
//
//  Created by tanmaydeep on 17/02/26.
//

import SwiftUI


extension SignupView {
    
     var usernameError: String? {
        guard usernameTouched else { return nil }
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Username cannot be empty."
        }
        return nil
    }

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
        usernameError != nil ||
        emailError != nil ||
        passwordError != nil
    }
    
     func handleSignup() {
        
        guard !isFormInvalid else { return }
        
        let trimmedUsername = username.trimmingCharacters(in: .whitespaces)
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        Task {
            let success = await authViewModel.createUser(
                email: trimmedEmail,
                password: password,
                username: trimmedUsername
            )
            
            if success {
                path = NavigationPath()
            }
        }
    }
}
