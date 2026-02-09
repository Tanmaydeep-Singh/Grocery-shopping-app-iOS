//
//  OrderServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

protocol OrderServiceProtocol {

    func createOrder(
        cartId: String,
        customerName: String
    ) async throws -> Order

    func fetchAllOrders() async throws -> [Order]

    func updateOrder(
        orderId: String,
        customerName: String,
        comment: String
    ) async throws -> Order
}


