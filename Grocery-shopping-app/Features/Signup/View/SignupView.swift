//
//  SignupView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//
//
//  LoginView.swift
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
    
    @EnvironmentObject var authViewModel : AuthViewModel

    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                Image("CarrotOrange")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.vertical, 30)
                
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
                    
                    VStack( alignment: .leading, spacing: 10) {
                        Text("signup_field_username")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        TextField("signup_field_username_placeholder", text: $username)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                        
                        Divider()
                    }
                    VStack( alignment: .leading, spacing: 10) {
                        
                        Text("signup_field_email")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        TextField("signup_field_email_placeholder", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        Divider()
                    }

                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("signup_field_password")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("signup_field_password_placeholder", text: $password)
                            } else {
                                SecureField("signup_field_password_placeholder", text: $password)
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        Divider()
                        
                        Text("signup_terms_text")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.secondary)
                    }
                }
                
                
               

                Button {
                    
                    Task{
                        await authViewModel.createUser(email: email, password: password, username: username)
                    }
                    
                    path.append(OnboardingRoutes.verification)
                } label: {
                    Text("signup_button_create_account")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 67)
                        .background(Color("Splash"))
                        .cornerRadius(19)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("signup_footer_existing_account")
                        .font(.system(size: 14, weight: .semibold))
                    Button{
                        path.append(OnboardingRoutes.login)
                    }
                    label: {
                        Text("signup_footer_login_button")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Splash"))
                    }
                }
            }
            .padding(25)
        }
    }
}
#Preview {
    SignupView(path: .constant(NavigationPath()))
}
