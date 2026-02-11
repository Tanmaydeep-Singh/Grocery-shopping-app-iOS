//
//  CartServices.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

final class CartServices: CartServiceProtocol {

    private let client: NetworkClient

    init(client: NetworkClient = .shared) {
        self.client = client
    }

    func createCart() async throws -> CreateCartResponse {
        try await client.request(
            endpoint: CartEndpoints.createCart
        )
    }

    func getCart(cartId: String) async throws -> Cart {
        try await client.request(
            endpoint: CartEndpoints.getCart(cartId: cartId)
        )
    }

    func getCartItems(cartId: String) async throws -> [CartItem] {
        try await client.request(
            endpoint: CartEndpoints.getCartItems(cartId: cartId)
        )
    }

    func addItem(
        cartId: String,
        productId: Int
    ) async throws -> Cart {

        let request = AddCartItemRequest(productId: productId)

        return try await client.request(
            endpoint: CartEndpoints.addItemToCart(
                cartId: cartId,
                body: request
            )
        )
    }

    func updateItemQuantity(
        cartId: String,
        itemId: String,
        quantity: Int
    ) async throws -> Cart {

        let request = UpdateCartItemQuantityRequest(
            quantity: quantity
        )

        return try await client.request(
            endpoint: CartEndpoints.updateCartItemQuantity(
                cartId: cartId,
                itemId: itemId,
                body: request
            )
        )
    }

    func replaceItem(
        cartId: String,
        itemId: String,
        productId: Int,
        quantity: Int
    ) async throws -> Cart {

        let request = ReplaceCartItemRequest(
            productId: productId,
            quantity: quantity
        )

        return try await client.request(
            endpoint: CartEndpoints.replaceCartItem(
                cartId: cartId,
                itemId: itemId,
                body: request
            )
        )
    }

    func removeItem(
        cartId: String,
        itemId: String
    ) async throws -> Cart {

        try await client.request(
            endpoint: CartEndpoints.removeCartItem(
                cartId: cartId,
                itemId: itemId
            )
        )
    }
}

