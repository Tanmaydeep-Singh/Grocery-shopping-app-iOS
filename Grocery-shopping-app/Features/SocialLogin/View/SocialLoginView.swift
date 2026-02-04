//
//  SocialLoginView.swift
//  Nectar
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct SocialLoginView: View {
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
                    .font(.title)
                    .lineLimit(2)
                    .bold()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button {
                    // Navigate to next screen
                } label: {
                    Text("Login with Number")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(Color("Splash"))
                .cornerRadius(12)
                .padding(.horizontal, 24)
            }
            .padding(20)
            
            Divider()

            VStack(alignment: .center, spacing: 20) {
                
                Text("Sign in with your social media account")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
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
                    .padding(.horizontal, 24)
                    
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
                    .padding(.horizontal, 24)
                }.padding(.bottom,20)
            }
            .padding(16)
        }
    }
}

#Preview {
    SocialLoginView()
}
