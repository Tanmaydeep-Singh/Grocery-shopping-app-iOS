//
//  CartViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import Foundation
import Combine

@MainActor
final class CartViewModel: ObservableObject {

    @Published var cartItems: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cartService: CartServiceProtocol
    private let productService: ProductServiceProtocol
    private var cartId: String?

    init() {
        self.cartService = CartServices()
        self.productService = ProductService()
    }

    func getCartItem(cartId: String) async  {
        isLoading = true

        defer { isLoading = false }
        
        do {
            let cartResp = try await cartService.getCart(cartId: cartId)
            var tempItems: [Product] = []

            
            for item in cartResp.items{
                var product = try await productService.fetchProduct(id: String(item.productId), showLabel: true)
                product.quantity = item.quantity
                product.cartProductId = item.id
                tempItems.append(product)
            }
            

            await MainActor.run {
                self.cartItems = tempItems
            }
        } catch {
            print(error)
        }
        
        
    }
    

    func increaseQuantity() {
    }

    func decreaseQuantity() {
       
    }

    private func updateQuantity() {
    }

    func removeItem(cartId: String, itemId: Int) async {
        do {
            print("cartId: \(cartId)")
            print("itemId: \(itemId)")

            let res = try await cartService.removeItem(
                cartId: cartId,
                itemId: String(itemId)
            )
            
            print(res)
        } catch {
            print(error)
        }
    }


    var totalPrice: Double {
        return 0;
    }
}
