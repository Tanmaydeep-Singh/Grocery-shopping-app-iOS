import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = OrdersViewModel()
    
    var body: some View {
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
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
                
                let calendar = Calendar.current
                let groupedOrders = Dictionary(
                    grouping: viewModel.orders.sorted(by: { $0.createdOn > $1.createdOn })
                ) { order in
                    calendar.startOfDay(for: order.createdOn)
                }
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 18) {
                        
                        ForEach(groupedOrders.keys.sorted(by: >), id: \.self) { date in
                            
                            Text(sectionTitle(for: date))
                                .font(.system(size: 18, weight: .bold))
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                            
                            VStack(spacing: 14) {
                                ForEach(groupedOrders[date] ?? []) { order in
                                    NavigationLink {
                                        OrderDetailsView(order: order)
                                    } label: {
                                        OrderRowView(order: order)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 18)
                }
            }
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.hidden, for: .tabBar)
        .task {
            guard let userId = authViewModel.user?.id else { return }
            await viewModel.fetchOrders(userId: userId)
        }
    }
    
    private func sectionTitle(for date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return date.formatted(date: .complete, time: .omitted)
        }
    }
}
