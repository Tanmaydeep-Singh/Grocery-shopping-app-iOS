//
//  SocialLoginView.swift
//  Nectar
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct SocialLoginView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            
            // Image
            Image("GroceriesBag")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(edges: .top)

            Spacer()
            
            VStack( alignment: .leading, spacing: 20) {
                Text("Get your groceries \n with nectar")
                    .font(.system(size: 26, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                                
                Button {
                    path.append(OnboardingRoutes.login)
                } label: {
                    Text("Login with Number")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(Color("Splash"))
                .cornerRadius(12)
                .padding(.vertical, 10)
            }
            .padding(20)
            
            Divider()

            VStack(alignment: .center, spacing: 20) {
                
                Text("Sign in with your social media account")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 16){
                    
                    Button {
                        // Navigate to next screen
                    } label: {
                        Text("signup with google")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }
                    .background(Color("Splash"))
                    .cornerRadius(12)
                    
                    Button {
                        // Navigate to next screen
                    } label: {
                        Text("signup with facebook")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }
                    .background(Color("Splash"))
                    .cornerRadius(12)
                    .padding(.vertical , 10)
                }.padding(.bottom,20)
            }
            .padding(16)
        }
    }
}

#Preview {
    SocialLoginView(path: .constant(NavigationPath()))
}
