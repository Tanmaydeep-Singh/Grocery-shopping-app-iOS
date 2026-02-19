import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = OrdersViewModel()
    
    var body: some View {
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
            content
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.hidden, for: .tabBar)
        .task {
            let userId = authViewModel.user?.id ?? ""
            await viewModel.fetchOrders(userId: userId)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        
        if viewModel.isLoading {
            
            VStack(spacing: 12) {
                ProgressView()
                Text("Loading your orders...")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
        }
        
        else if viewModel.orders.isEmpty {
            
            VStack(spacing: 12) {
                Image(systemName: "cart")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)
                
                Text("No Orders Yet")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Your completed orders will appear here.")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
        
        else {
            
            ScrollView {
                LazyVStack(spacing: 14) {
                    
                    ForEach(viewModel.orders) { order in
                        
                        NavigationLink {
                            OrderDetailsView(order: order)
                        } label: {
                            OrderRowView(order: order)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
            }
        }
    }
}
