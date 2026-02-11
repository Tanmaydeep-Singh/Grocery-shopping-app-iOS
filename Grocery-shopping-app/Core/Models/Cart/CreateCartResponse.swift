//
//  CreateCartResponse.swift
//  Nectar
//
//  Created by tanmaydeep on 11/02/26.
//

import Foundation

struct CreateCartResponse : Codable {
    let created: Bool
    let cartId: String
}
