//
//  OrdersViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import Foundation
import Combine

@MainActor
final class OrdersViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let ordersService: OrderServiceProtocol
    
    init(service: OrderServiceProtocol = OrderService()) {
        self.ordersService = service
    }
    
    func fetchOrders(userId: String) async {
        guard !userId.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            self.orders = try await ordersService.fetchAllOrders(userId: userId)
            isLoading = false
        } catch {
            self.errorMessage = "Failed to fetch orders: \(error.localizedDescription)"
            isLoading = false
        }
    }
}
