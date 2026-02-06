//
//  CartItems.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import Foundation

struct CartItem: Codable, Identifiable {
    let id: String
    let productName: String
    let productImageURL: String
    let unitDescription: String
    let price: Double
    var quantity: Int
}
