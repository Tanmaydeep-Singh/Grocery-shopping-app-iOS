//
//  OrderServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

protocol OrderServiceProtocol {

    func createOrder(
        userId: String,
        items: [CartProduct],
        totalPrice: Double
    ) async throws -> Bool

    func fetchAllOrders(
        userId: String
    ) async throws -> [Order]

}

