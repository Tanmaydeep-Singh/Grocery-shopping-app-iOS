//
//  RateOrdersViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 23/02/26.
//

import Foundation
import Combine

@MainActor
final class RateOrdersViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let ordersService: OrderServiceProtocol
    private let authViewModel: AuthViewModel
    
    init() {
        self.ordersService = OrderService()
        self.authViewModel = AuthViewModel()
    }
    
    func updateOrderRating(orderId: String, rating: Int) async -> Bool {
        
        errorMessage = nil
        isLoading = true
        
        defer { isLoading = false }
        do {
            guard let userId = authViewModel.user?.id else {
                return false
            }
            try await ordersService.updateOrderRating(userId: userId , orderId: orderId, rating: rating)
            return true
        } catch {
            self.errorMessage = "Failed to update rating"
            return false
        }
    }
}



