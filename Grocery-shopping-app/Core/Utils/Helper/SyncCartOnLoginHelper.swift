//
//  File.swift
//  Nectar
//
//  Created by tanmaydeep on 12/02/26.
//

import Foundation

final class SyncCartOnLoginHelper {
    
    private let cartService: CartServiceProtocol = CartServices()
    private let productService: ProductServiceProtocol = ProductService()
    
    func getCartItems(cartId: String) async {
      
        do {
            let cartResp = try await cartService.getCart(cartId: cartId)
            var tempItems: [Product] = []

            for item in cartResp.items {
                var productDetail = try await productService.fetchProduct(id: String(item.productId), showLabel: true)
                
                productDetail.quantity = item.quantity
                productDetail.cartProductId = item.id
                tempItems.append(productDetail)
            }

            CartProductsService.shared.syncCart(products: tempItems)
            
        } catch {
            print("Sync Error: \(error)")
        }
    }
    
}
