//
//  ProductCardViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 12/02/26.
//

import Foundation
import Combine

@MainActor
final class ProductCardViewModel: ObservableObject {
    
    private let cartService: CartServiceProtocol = CartServices()

    func addToCart(cartId: String, productId: Int) async {
        do {
            _ = try await cartService.addItem(cartId: cartId, productId: productId)
        } catch {
            print("Failed to add item to cart: \(error)")
        }
    }
}
