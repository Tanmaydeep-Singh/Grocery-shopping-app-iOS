//
//  LoginView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct LoginView: View {

    @Binding var path: NavigationPath

    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var showResetSuccessAlert = false

    @FocusState private var focusedField: Field?
    @State private var emailTouched = false
    @State private var passwordTouched = false

    enum Field {
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
                    .padding(.vertical, 30)

                VStack(alignment: .leading, spacing: 10) {
                    Text("login_title")
                        .font(.system(size: 26, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("login_subtitle")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)

                VStack(spacing: 25) {

                    VStack(alignment: .leading, spacing: 5) {
                        Text("login_email_title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)

                        TextField("login_email_placeholder", text: $email)
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
                        Text("login_password_title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)

                        HStack {
                            if isPasswordVisible {
                                TextField("login_password_placeholder", text: $password)
                                    .focused($focusedField, equals: .password)
                                    .onChange(of: password) { _ in
                                        passwordTouched = true
                                    }
                            } else {
                                SecureField("login_password_placeholder", text: $password)
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
                }

                Button {
                    handlePasswordReset()
                } label: {
                    Text("login_forgot_password")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.primary)
                }

                Button {
                    handleLogin()
                } label: {
                    Group {
                        if authViewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("login_button")
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(isFormInvalid ? Color.gray : Color("Splash"))
                    .cornerRadius(19)
                }
                .disabled(isFormInvalid || authViewModel.isLoading)
                .padding(.top, 10)

                HStack {
                    Text("login_no_account_text")
                        .font(.system(size: 14, weight: .semibold))

                    Button {
                        path.append(OnboardingRoutes.signup)
                    } label: {
                        Text("login_signup_button")
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

        .alert("Password Reset", isPresented: $showResetSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("A password reset link has been sent to your email.")
        }
    }
}

extension LoginView {

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
        emailError != nil ||
        passwordError != nil
    }

    private func handleLogin() {

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

    private func handlePasswordReset() {
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

#Preview {
    LoginView(path: .constant(NavigationPath()))
        .environmentObject(AuthViewModel())
}
