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
    
    init() {
        self.ordersService = OrderService()
    }
    
    func updateOrderRating(userId : String , orderId: String, rating: Int) async -> Bool {
        
        errorMessage = nil
        isLoading = true
        
        defer { isLoading = false }
        do {
           
            try await ordersService.updateOrderRating(userId: userId , orderId: orderId, rating: rating)
            return true
        } catch {
            self.errorMessage = "Failed to update rating"
            return false
        }
    }
    
    // get order rating
    func fetchRating(userId : String, orderId: String) async -> Int? {
        
        do {
                      print("called: \(userId), \(orderId)")

            return try await ordersService
                .getOrderRating(userId: userId, orderId: orderId)
        } catch {
            errorMessage = "Failed to fetch rating"
            return nil
        }
    }
}



