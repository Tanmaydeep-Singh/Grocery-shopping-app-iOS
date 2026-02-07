import SwiftUI

struct AccountView: View {

    @StateObject private var viewModel = AccountViewModel()

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Profile Header
            
            HStack(spacing: 14) {

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(viewModel.userName)
                            .font(.headline)

                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                    }

                    Text(viewModel.userEmail)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.vertical,18)


            Divider()
                .background(Color.gray.opacity(0.9))
                .frame(height: 2)

//             MARK: - Options List
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.menuItems) { item in
                        VStack(spacing: 0) {
                            AccountRowView(item: item)
                                .padding(.vertical, 13)
                                .padding(.horizontal, 16)

                            Divider()
//                                .padding(.leading, 56)
                        }
                        .background(Color.white)
                    }
                }
            }
            
            
            // MARK: - Logout Button

            
            PrimaryButton(
                title: "Log Out",
                icon: "arrow.backward.square",
                textColor: .green,
                backgroundColor: Color.green.opacity(0.12),
                height: 56,
                cornerRadius: 14
            ) {
                viewModel.logout()
            }
            .padding(.bottom, 20)


        }
        .navigationTitle("Account")
    }
}

#Preview {
    AccountView()
}

