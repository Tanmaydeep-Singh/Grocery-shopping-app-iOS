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

struct CartBackupItem {
    let id: Int64
    let name: String?
    let price: Double
    let inStock: Bool
    let imageName: String?
    let cartProductId: Int64
    let quantity: Int64
}
