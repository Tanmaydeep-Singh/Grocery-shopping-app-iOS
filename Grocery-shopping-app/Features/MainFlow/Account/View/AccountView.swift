import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 14) {
                if let avatar = authViewModel.user?.avatar, !avatar.isEmpty {
                    Image(avatar)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(05)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.green, lineWidth: 2))
                        .padding(.top, 20)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(authViewModel.user?.username ?? "guest user")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }

                    Text(authViewModel.user?.email ?? "guest@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.vertical,18)


            Divider()
                .background(Color.gray.opacity(0.9))
                .frame(height: 2)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.menuItems) { item in
                        
                        VStack(spacing: 0) {
                            
                            if let destination = item.destination {
                                
                                NavigationLink {
                                    destinationView(for: destination)
                                } label: {
                                    AccountRowView(item: item)
                                        .padding(.vertical, 13)
                                        .padding(.horizontal, 16)
                                }
                                .buttonStyle(.plain)
                                
                            } else {
                                
                                AccountRowView(item: item)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 16)
                            }

                            Divider()
                        }
                        .background(Color.white)
                    }
                }
            }

            PrimaryButton(
                title: "Log Out",
                icon: "arrow.backward.square",
                textColor: .green,
                backgroundColor: Color.green.opacity(0.12),
            ) {
                Task{
                    authViewModel.logout()
                    router.selectedTab = .home
                }
            }
            .padding(20)
        }
        .navigationTitle("Account")
    }
}

/// Helper builder func
@ViewBuilder
private func destinationView(for destination: AccountDestination) -> some View {
    
    switch destination {
        
    case .orders:
        OrdersView()
        
    case .myDetails:
        MyDetailsView()
        
    case .deliveryAddress:
        ComingSoonView()
        
        
    case .paymentMethods:
        ComingSoonView()
        
        
    case .promoCard:
        ComingSoonView()
       
        
    case .notifications:
        ComingSoonView()
        
        
    case .help:
        ComingSoonView()
        
        
    case .about:
        AboutView()
    }
}


#Preview {
    AccountView()
}

