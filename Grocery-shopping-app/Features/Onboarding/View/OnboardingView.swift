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

                Text("Welcome\nto our store")
                    .font(.system(size: 50, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Text("Get your groceries in as fast as one hour")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer().frame(height: 24)

                Button {
                    path.append(OnboardingRoutes.socialLogin)
                } label: {
                    Text("Get Started")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(Color("Splash"))
                .cornerRadius(12)
                .padding(.horizontal, 24)

                Spacer().frame(height: 60)
            }
        }
    }
}

#Preview {
    OnboardingView(path: .constant(NavigationPath()))
}
