//
//  CartProductDTO.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import Foundation

struct CartProductDTO: Codable, Sendable, Identifiable {
    var id: Int64
    var name: String
    var price: Double
    var quantity: Int
    var imageName: String
    var category: String
    var cartProductId: Int64
}
