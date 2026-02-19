//
//  MyDetails.swift
//  Nectar
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct MyDetailsView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var username: String = ""
    @State private var email: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.green)
                    .padding(.top, 20)

                VStack(spacing: 16) {

                    DetailTextField(
                        title: "Username",
                        text: $username,
                        isEditable: false
                    )

                    DetailTextField(
                        title: "Email",
                        text: $email,
                        isEditable: false
                    )

                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 10)

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("My Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadUserData()
        }
    }

    private func loadUserData() {
        username = authViewModel.user?.username ?? ""
        email = authViewModel.user?.email ?? ""
    }
}


