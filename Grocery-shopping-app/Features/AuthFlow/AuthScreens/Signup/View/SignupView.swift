//
//  SignupView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct SignupView: View {
    
    @Binding var path: NavigationPath
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @FocusState private var focusedField: Field?

    @State private var usernameTouched = false
    @State private var emailTouched = false
    @State private var passwordTouched = false

    enum Field {
        case username
        case email
        case password
    }

    
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                Image("CarrotOrange")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.vertical, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("signup_title")
                        .font(.system(size: 26, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("signup_subtitle")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("signup_field_username")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        TextField("signup_field_username_placeholder", text: $username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusedField, equals: .username)
                               .onChange(of: username) { _ in
                                   usernameTouched = true
                               }
                        
                        Divider()
                        
                        if let error = usernameError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("signup_field_email")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        TextField("signup_field_email_placeholder", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusedField, equals: .email)
                               .onChange(of: email) { _ in
                                   emailTouched = true
                               }
                        
                        Divider()
                        
                        if let error = emailError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("signup_field_password")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("signup_field_password_placeholder", text: $password)
                            } else {
                                SecureField("signup_field_password_placeholder", text: $password)
                                    .focused($focusedField, equals: .password)
                                        .onChange(of: password) { _ in
                                            passwordTouched = true
                                        }
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Divider()
                        
                        if let error = passwordError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    Text("signup_terms_text")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                Button {
                    handleSignup()
                } label: {
                    Group {
                        if authViewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("signup_button_create_account")
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 67)
                    .background(isFormInvalid ? Color.gray : Color("Splash"))
                    .cornerRadius(19)
                }
                .disabled(isFormInvalid || authViewModel.isLoading)
                .padding(.top, 10)
                
                HStack {
                    Text("signup_footer_existing_account")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Button {
                        path.append(OnboardingRoutes.login)
                    } label: {
                        Text("signup_footer_login_button")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Splash"))
                    }
                }
            }
            .padding(25)
        }
        .alert("Error", isPresented: $authViewModel.isError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(authViewModel.errorMessage ?? "An unknown error occurred.")
        }
    }
}

extension SignupView {
    
    private var usernameError: String? {
        guard usernameTouched else { return nil }
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Username cannot be empty."
        }
        return nil
    }

    private var emailError: String? {
        guard emailTouched else { return nil }
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Email cannot be empty."
        }
        if !authViewModel.isValidEmail(email) {
            return "Please enter a valid email address."
        }
        return nil
    }

    private var passwordError: String? {
        guard passwordTouched else { return nil }
        if password.isEmpty {
            return "Password cannot be empty."
        }
        if !authViewModel.isValidPassword(password) {
            return "Minimum 8 characters & 1 special character required."
        }
        return nil
    }

    
    private var isFormInvalid: Bool {
        usernameError != nil ||
        emailError != nil ||
        passwordError != nil
    }
    
    private func handleSignup() {
        
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

#Preview {
    SignupView(path: .constant(NavigationPath()))
        .environmentObject(AuthViewModel())
}
