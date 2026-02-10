//
//  CreateOrderRequest.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

struct CreateOrderRequest: Encodable {
    let cartId: String
    let customerName: String
}
