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
    
    @Published var isInCart: Bool = false
    @Published var quantity: Int = 1
    
    private let cartService: CartServiceProtocol = CartServices()
    private let cartProductsService: CartProductsService = CartProductsService()
    
    
    func addToCart(cartId: String, product: Product?) async {
        
        guard let productId = product?.id else {
            return
        }

        do {
           let cartRes = try await cartService.addItem(cartId: cartId, productId: productId)
            
            if let productDetail = product {
                cartProductsService.addCartProduct(product: product, cartProductId: cartRes.itemId)
            }
            isInCart = true
            
        } catch {
            print(error)
        }
    }
    
    func onLoad(productId: Int) async {
        isInCart = await cartProductsService.isProductInCart(productId: productId)
        quantity = await Int(cartProductsService.getProductById(productId: productId)?.quantity ?? 1)

    }
}
