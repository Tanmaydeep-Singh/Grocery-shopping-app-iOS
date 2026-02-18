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
                            NavigationLink {
                                OrderDetailsView(order: order)                            } label: {
                                OrderRowView(order: order)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 16)
                            }
                            .buttonStyle(.plain)
                            Divider()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Orders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear() {
            Task{
                let userId = authViewModel.user?.id ?? ""
                await viewModel.fetchOrders(userId: userId)
            }
        }
    }
}

#Preview {
    NavigationStack {
        OrdersView()
            .environmentObject(AuthViewModel())
    }
}
