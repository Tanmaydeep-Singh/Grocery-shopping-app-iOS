//
//  SocialLoginView.swift
//  Nectar
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct SocialLoginView: View {
    
    @Binding var path: NavigationPath
    @EnvironmentObject var authViewModel : AuthViewModel

    
    var body: some View {
        VStack {
            
            // Image
            Image("GroceriesBag")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(edges: .top)

            Spacer()
            
            VStack( alignment: .leading, spacing: 20) {
            
                VStack(alignment: .leading, spacing: 0) {
                                   Text("social_login_title_line1")
                                   Text("social_login_title_line2")
                               }
                               .font(.system(size: 26, weight: .semibold))
                               .frame(maxWidth: .infinity, alignment: .leading)

                    
                                
                Button {
                    path.append(OnboardingRoutes.login)
                } label: {
                    Text("social_login_button_phone")
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
            

            VStack(alignment: .center, spacing: 20) {
                
                Text("social_login_subtitle")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 16){
                    
                    Button {
                        authViewModel.signInWithGoogle()
                    } label: {
                        HStack(spacing: 12) {
                            Image("GoogleLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("social_login_button_google")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color("GoogleButton"))
                        .cornerRadius(14)
                    }

                    
                    Button {
                        authViewModel.signInWithGoogle()
                    } label: {
                        HStack(spacing: 12) {
                            Image("FacebookLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("social_login_button_facebook")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color("FacebookButton"))
                        .cornerRadius(14)
                    }
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
