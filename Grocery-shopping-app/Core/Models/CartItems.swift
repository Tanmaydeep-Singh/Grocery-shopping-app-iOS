//
//  CartItems.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import Foundation

struct CartItem: Codable, Identifiable {
    let id: Int
    let productId: Int
    let quantity: Int
}
