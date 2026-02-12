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
    private let cartProductsService : CartProductsService
    private var cartId: String?

    init() {
        self.cartService = CartServices()
        self.productService = ProductService()
        self.cartProductsService = CartProductsService()
    }

    func getCartItem(cartId: String) async  {
        isLoading = true

        defer { isLoading = false }
        
        do {
            
            let cpsresp = cartProductsService.getProducts()
            print("cpsresp: \(cpsresp)")
            
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
    

   


    func removeItem(cartId: String, itemId: Int) async {
        do {
            _ = try await cartService.removeItem(cartId: cartId, itemId: String(itemId))
            cartItems = cartItems.filter {
                        $0.cartProductId != itemId
                    }
            print("LIST: \(cartItems)")

        } catch {
            print("Failed to remove item:", error)
        }
    }


    var totalPrice: Double {
        var price: Double = 0

        for item in cartItems {
            let itemPrice = item.price ?? 0
            let quantity = Double(item.quantity ?? 0)
            price += itemPrice * quantity
        }
        return price
    }

    
    // Array to track items for debounce
    private var debounceTasks: [Int: Task<Void, Never>] = [:]
    
    // Helper func for decounce
    func updateLocalQuantity(cartId: String, itemId: Int, quantity: Int) {

           if let index = cartItems.firstIndex(where: { $0.cartProductId == itemId }) {
               cartItems[index].quantity = quantity
           }

           debounceTasks[itemId]?.cancel()

           debounceTasks[itemId] = Task {
               try? await Task.sleep(nanoseconds: 2_500_000_000) // 2.5 sec for debounce

               await updatedQuantity(
                   cartId: cartId,
                   itemId: itemId,
                   quantity: quantity
               )
           }
       }
    
    //Update Item
    func updatedQuantity(
        cartId: String,
        itemId: Int,
        quantity: Int
        
    ) async {
        do {
            print("CART ID : \(cartId) ITEM ID: \(itemId) QUANTITY: \(quantity)")
            _ = try await cartService.updateItemQuantity(cartId: cartId, productId: String(itemId), quantity: quantity )
        }
        catch {
            print("Failed to update item:", error)
        }
        
    }
}
