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

    @Published var cartItems: [CartProduct] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    var totalItemsPrice: Double = 0;

    private let cartService: CartServiceProtocol
    private let productService: ProductServiceProtocol
    private let cartProductsService : CartProductsService
    private let orderService: OrderServiceProtocol
    private var cartId: String?

    init() {
        self.cartService = CartServices()
        self.productService = ProductService()
        self.cartProductsService = CartProductsService()
        self.orderService = OrderService()
    }

    
    //Get cart item
    func getCartItem(cartId: String) async {
        isLoading = true
        defer { isLoading = false }
        print(" CALLED TO GET CART DATA")
        do {
            let products = await cartProductsService.getProducts()
            print("products: \(products)")
            self.cartItems = products
        }
    }

    

    func removeItem(cartId: String, itemId: Int) async {
        do {
            print("itemId:  \(itemId)")

            _ = try await cartService.removeItem(cartId: cartId, itemId: String(itemId))
            cartItems = cartItems.filter {
                        $0.cartProductId != itemId
                    }
            cartProductsService.removeCartItem(itemId:itemId)

        } catch {
            print("Failed to remove item:", error)
        }
    }


    var totalPrice: Double {
        var price: Double = 0

        for item in cartItems {
            let itemPrice = item.price
            let quantity = Double(item.quantity)
            price += itemPrice * quantity
        }
        totalItemsPrice = price
        return price
    }

    
    // Array to track items for debounce
    private var debounceTasks: [Int: Task<Void, Never>] = [:]
    
    // Helper func for decounce
    func updateLocalQuantity(cartId: String, itemId: Int, quantity: Int) {

           if let index = cartItems.firstIndex(where: { $0.cartProductId == itemId }) {
               cartItems[index].quantity =  Int64(quantity)
           }

           debounceTasks[itemId]?.cancel()

           debounceTasks[itemId] = Task {
               try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 sec for debounce

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
            _ = try await cartService.updateItemQuantity(cartId: cartId, productId: String(itemId), quantity: quantity )

        }
        catch {
            print(error)
        }
        
    }
    
    // Create Order.
    func createOrder(userId: String) async -> Bool {
        guard !userId.isEmpty else { return false }
        
        let itemsToOrder = cartItems.map { item in
            CartProductDTO(
                id: item.id,
                name: item.name ?? "Unknown",
                price: item.price,
                quantity: Int(item.quantity),
                imageName: item.imageName ?? "",
                category: item.category ?? "General",
                cartProductId: item.cartProductId
            )
        }
        
        do {
            _ = try await orderService.createOrder(
                userId: userId,
                items: itemsToOrder,
                totalPrice: totalItemsPrice
            )
            return true
        } catch {
            print("Order creation failed: \(error)")
            return false
        }
    }
}
