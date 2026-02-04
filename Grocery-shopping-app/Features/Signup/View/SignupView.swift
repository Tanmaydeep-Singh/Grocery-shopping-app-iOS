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

    @State private var username = ""
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
                    Text("Sign-up")
                        .font(.system(size: 26, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Enter your credentials to continue.")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 25) {
                    customInputField(title: "Username", placeholder: "Enter your username", text: $username)
                    customInputField(title: "Email", placeholder: "Enter your email", text: $email)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Password")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
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
                
               

                Button {
                    // Login Logic
                } label: {
                    Text("Log In")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 67)
                        .background(Color("Splash"))
                        .cornerRadius(19)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Login")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Splash"))
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
    SignupView()
}
