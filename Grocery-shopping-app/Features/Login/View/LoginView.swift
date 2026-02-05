//
//  LoginView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    
    @Binding var path: NavigationPath

    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
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
                    customInputField(title: "email_title", placeholder: "email_placeholder", text: $email)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("password_title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("password_placeholder", text: $password)
                            } else {
                                SecureField("password_placeholder", text: $password)
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        Divider()
                    }
                }
                
                Button { } label: {
                    Text("forgot_password")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.primary)
                }

                Button {
                    path.append(OnboardingRoutes.verification)
                } label: {
                    Text("login_button")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 67)
                        .background(Color("Splash"))
                        .cornerRadius(19)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("no_account_text")
                        .font(.system(size: 14, weight: .semibold))
                    Button{
                        path.append(OnboardingRoutes.signup)
                    } label: {
                        Text("login_button")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Splash"))
                    }
                }
            }
            .padding(25)
        }
    }
    
    @ViewBuilder
    func customInputField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            TextField(placeholder, text: text)
                .keyboardType(title == "Email" ? .emailAddress : .default)
                .autocapitalization(.none)
            Divider()
        }
    }
}
#Preview {
    LoginView( path: .constant(NavigationPath()))
}
