//
//  OrdersViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import Foundation

struct DummyOrder: Identifiable {
    let id: String
    let createdOn: Date
    let items: [DummyOrderItem]
    let totalPrice: Double
}

struct DummyOrderItem {
    let productId: Int
    let name: String
    let price: Double
    let quantity: Int
    let imageName: String
}

extension DummyOrder {
    
    static let sampleOrders: [DummyOrder] = [
        DummyOrder(
            id: "1",
            createdOn: Date(),
            items: [
                DummyOrderItem(
                    productId: 1,
                    name: "Organic Bananas",
                    price: 120,
                    quantity: 2,
                    imageName: "banana"
                ),
                DummyOrderItem(
                    productId: 2,
                    name: "Fresh Milk",
                    price: 60,
                    quantity: 1,
                    imageName: "milk"
                )
            ],
            totalPrice: 300
        ),
        
        DummyOrder(
            id: "2",
            createdOn: Date().addingTimeInterval(-86400),
            items: [
                DummyOrderItem(
                    productId: 3,
                    name: "Brown Bread",
                    price: 45,
                    quantity: 3,
                    imageName: "bread"
                )
            ],
            totalPrice: 135
        )
    ]
}
