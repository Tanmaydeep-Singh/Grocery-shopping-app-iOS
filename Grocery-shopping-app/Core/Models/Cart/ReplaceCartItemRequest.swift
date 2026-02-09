//
//  ReplaceCartItemRequest.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

struct ReplaceCartItemRequest: Encodable {
    let productId: Int
    let quantity: Int
}
