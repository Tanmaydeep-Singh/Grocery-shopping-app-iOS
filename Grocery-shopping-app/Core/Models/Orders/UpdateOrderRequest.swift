//
//  UpdateOrderRequest.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

struct UpdateOrderRequest: Encodable {
    let customerName: String
    let comment: String
}
