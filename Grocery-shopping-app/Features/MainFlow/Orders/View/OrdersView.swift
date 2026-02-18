//
//  OrdersView.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//
import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = OrdersViewModel()

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if viewModel.orders.isEmpty {
                VStack(spacing: 12) {
                    Text("No Orders Yet")
                        .font(.headline)
                }
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.orders) { order in
                            OrderRowView(order: order)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Orders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            let userId = authViewModel.user?.id ?? ""
            await viewModel.fetchOrders(userId: userId)
        }
    }
}

#Preview {
    NavigationStack {
        OrdersView()
            .environmentObject(AuthViewModel())
    }
}
