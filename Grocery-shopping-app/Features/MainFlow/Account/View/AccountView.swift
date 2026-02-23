import SwiftUI

struct AccountView: View {
    

    @StateObject private var viewModel = AccountViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject var router: AppRouter

    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 14) {

                Image("person.crop.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
             

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(authViewModel.user?.username ?? "guest user")
                            .font(.title3)
                            .fontWeight(.semibold)
                        

                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                    }

                    Text(authViewModel.user?.email ?? "guest@gmail.com")
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
        Text("Delivery Address View")
        
    case .paymentMethods:
        Text("Payment Methods View")
        
    case .promoCard:
        Text("Promo Card View")
        
    case .notifications:
        Text("Notifications View")
        
    case .help:
        Text("Help View")
        
    case .about:
        AboutView()
    }
}


#Preview {
    AccountView()
}

