//
//  OrderServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

protocol OrderServiceProtocol {

    // create order
    func createOrder(
        userId: String,
        items: [CartProductDTO],
        totalPrice: Double
    ) async throws -> Bool

    // fetch all orders
    func fetchAllOrders(
        userId: String
    ) async throws -> [Order]

    // update cartId
    func updateUserCartId(
        userId: String,
        cartId: String
    ) async throws
    
    // get order by ID
    func fetchOrderById(
        userId: String,
        orderId: String
    ) async throws -> Order
    
    // update order rating
    func updateOrderRating(
        userId: String,
        orderId: String,
        rating: Int
    ) async throws
    
}

