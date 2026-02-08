//
//  OrderService.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

final class OrderService: OrderServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = .shared) {
        self.networkClient = networkClient
    }

    func createOrder(
        cartId: String,
        customerName: String
    ) async throws -> Order {

        let request = CreateOrderRequest(
            cartId: cartId,
            customerName: customerName
        )

        return try await networkClient.request(
            endpoint: OrderEndpoints.createOrder(request)
        )
    }

    func fetchAllOrders() async throws -> [Order] {
        try await networkClient.request(
            endpoint: OrderEndpoints.getAllOrders
        )
    }

    func updateOrder(
        orderId: String,
        customerName: String,
        comment: String
    ) async throws -> Order {

        let request = UpdateOrderRequest(
            customerName: customerName,
            comment: comment
        )

        return try await networkClient.request(
            endpoint: OrderEndpoints.updateOrder(
                orderId: orderId,
                body: request
            )
        )
    }
}

