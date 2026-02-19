//
//  AboutView.swift
//  Nectar
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct AboutView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                VStack(spacing: 12) {
                    Image("CarrotOrange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)

                    Text("Nectar")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Fresh groceries delivered to your doorstep.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)

                VStack(alignment: .leading, spacing: 12) {
                    Text("About Nectar")
                        .font(.headline)

                    Text("""
Nectar is your one-stop destination for fresh groceries, daily essentials, and household items — delivered fast and reliably.

We partner with trusted suppliers to ensure high-quality products at affordable prices, making everyday shopping simple and convenient.
""")
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Why Choose Us")
                        .font(.headline)

                    FeatureRow(icon: "leaf.fill", text: "Fresh & high-quality products")
                    FeatureRow(icon: "clock.fill", text: "Fast doorstep delivery")
                    FeatureRow(icon: "cart.fill", text: "Wide range of groceries")
                    FeatureRow(icon: "creditcard.fill", text: "Secure payments")
                }

                Text("Version 1.0.0")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 10)

            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AboutView()
}
