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

    @State private var showAvatarOptions = false
    @State private var showAvatarSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Button {
                    showAvatarOptions = true
                } label: {
                    if let avatar = authViewModel.user?.avatar, !avatar.isEmpty {
                        Image(avatar)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(15)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.green, lineWidth: 2))
                            .padding(.top, 20)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .padding(.top, 20)
                    }
                }

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
        .confirmationDialog(
            "Profile Photo",
            isPresented: $showAvatarOptions,
            titleVisibility: .visible
        ) {
            Button("Select Avatar") {
                showAvatarSheet = true
            }
            
            if authViewModel.user?.avatar != nil {
                Button("Remove Avatar", role: .destructive) {
                    Task {
                        await authViewModel.updateAvatar(avatarName: nil)
                    }
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showAvatarSheet) {
            AvatarPickerSheet()
                .environmentObject(authViewModel)
        }
    }

    private func loadUserData() {
        username = authViewModel.user?.username ?? ""
        email = authViewModel.user?.email ?? ""
    }
}


