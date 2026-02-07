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
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("login_email_title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        TextField("login_email_placeholder", text: $email)
                            .keyboardType("login_email_title" == "Email" ? .emailAddress : .default)
                            .autocapitalization(.none)
                        Divider()
                    }
                   
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("login_password_title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("login_password_placeholder", text: $password)
                            } else {
                                SecureField("login_password_placeholder", text: $password)
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
                    Text("login_forgot_password")
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
                    Text("login_no_account_text")
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
    
    
}
#Preview {
    LoginView( path: .constant(NavigationPath()))
}
