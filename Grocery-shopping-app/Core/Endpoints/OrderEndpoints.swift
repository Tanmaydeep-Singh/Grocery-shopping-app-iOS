//
//  OrderEndpoints.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//
//
//  OrderEndpoints.swift
//  Nectar
//

import Foundation

enum OrderEndpoints: Endpoint {


    // Order Base Cases
    case createOrder(CreateOrderRequest)
    case getAllOrders
    case updateOrder(
        orderId: String,
        body: UpdateOrderRequest
    )

    var path: String {
        switch self {
        case .createOrder, .getAllOrders:
            return "orders"
        case .updateOrder(let orderId, _):
            return "orders/\(orderId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .createOrder:
            return .post
        case .getAllOrders:
            return .get
        case .updateOrder:
            return .patch
        }
    }

    var body: Encodable? {
        switch self {
        case .createOrder(let request):
            return request
        case .updateOrder(_, let request):
            return request
        default:
            return nil
        }
    }
}
