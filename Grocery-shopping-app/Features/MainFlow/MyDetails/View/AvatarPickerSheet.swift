//
//  AvatarPickerSheet.swift
//  Nectar
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI

struct AvatarPickerSheet: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    let avatars = [
        "avatar_b_6","avatar_b_7","avatar_b_8","avatar_b_9",
        "avatar_b_10","avatar_b_11","avatar_b_12","avatar_g_1","avatar_g_2","avatar_g_3","avatar_g_4","avatar_g_5","avatar_g_6"
    ]

    @State private var selectedAvatar: String?

    var body: some View {

        NavigationStack {

            VStack {

                HStack {

                    Button("Cancel") {
                        dismiss()
                    }

                    Spacer()

                    Button("Save") {

                        guard let avatar = selectedAvatar else { return }

                        Task {
                            await authViewModel.updateAvatar(avatarName: avatar)
                            dismiss()
                        }
                    }
                    .fontWeight(.semibold)
                }
                .padding()
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                    .padding(.horizontal)
                
                ScrollView {

                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 80), spacing: 20)],
                        spacing: 20
                    ) {

                        ForEach(avatars, id: \.self) { avatar in
                            Image(avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .padding(15)
                                .background(
                                    Circle().fill(Color(.systemBackground))
                                )
                                .overlay(
                                    Circle()
                                        .stroke(
                                            selectedAvatar == avatar ? Color.green : Color.gray.opacity(0.35),
                                            lineWidth: selectedAvatar == avatar ? 4 : 2
                                        )
                                )
                                .shadow(
                                    color: selectedAvatar == avatar ? Color.green.opacity(0.45) : .clear,
                                    radius: selectedAvatar == avatar ? 10 : 0
                                )
                                .scaleEffect(selectedAvatar == avatar ? 1.1 : 1)
                                .animation(.spring(response: 0.35, dampingFraction: 0.65), value: selectedAvatar)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                                        selectedAvatar = avatar
                                    }
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Select Avatar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
