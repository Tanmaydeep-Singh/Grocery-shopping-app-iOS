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

    func getCartItems(cartId: String) async throws -> [CartItem]

    func addItem(
        cartId: String,
        productId: Int
    ) async throws -> Cart

    func updateItemQuantity(
        cartId: String,
        itemId: String,
        quantity: Int
    ) async throws -> Cart

    func replaceItem(
        cartId: String,
        itemId: String,
        productId: Int,
        quantity: Int
    ) async throws -> Cart

    func removeItem(
        cartId: String,
        itemId: String
    ) async throws -> Cart
}
