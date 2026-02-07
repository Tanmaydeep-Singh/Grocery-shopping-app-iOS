//
//  OnboardingView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {

            Image("Onboarding")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.45)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Image("CarrotWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                VStack(spacing: 0) {
                    Text("onboarding_title_welcome_line1")
                    Text("onboarding_title_welcome_line2")
                }                    .font(.system(size: 50, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Text("onboarding_subtitle_welcome")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer().frame(height: 24)
                
                PrimaryButton(title:"onboarding_button_get_started"){
                    path.append(OnboardingRoutes.socialLogin)
                }
                


                Spacer().frame(height: 60)
            }
        }
    }
}

#Preview {
    OnboardingView(path: .constant(NavigationPath()))
}
