//
//  AuthFlowView.swift
//  Nectar
//
//  Created by tanmaydeep on 07/02/26.
//

import SwiftUI

struct AuthFlowView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            OnboardingView(path: $path)
                .navigationDestination(for: OnboardingRoutes.self) { route in
                    switch route {
                    case .socialLogin:
                        SocialLoginView(path: $path)

                    case .login:
                        LoginView(path: $path)

                    case .signup:
                        SignupView(path: $path)

                    case .verification:
                        VerificationScreen(path: $path)

                    case .location:
                        LocationView(path: $path)
                    }
                }
        }
    }
}

#Preview {
    AuthFlowView()
        .environmentObject(AuthViewModel())
}
