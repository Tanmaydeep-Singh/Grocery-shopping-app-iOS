//
//  CartServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

protocol CartServiceProtocol {

    func createCart() async throws -> CreateCartResponse

    func getCart(cartId: String) async throws -> Cart


    func addItem(
        cartId: String,
        productId: Int
    ) async throws -> AddCartItemResponse

    
    func updateItemQuantity(
        cartId: String,
        productId: String,
        quantity: Int
    ) async throws -> EmptyResponse

    
    func removeItem(
        cartId: String,
        itemId: String
    ) async throws -> EmptyResponse
}
