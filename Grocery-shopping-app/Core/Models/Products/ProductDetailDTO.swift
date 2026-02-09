//
//  ProductDetailDTO.swift
//  Nectar
//
//  Created by rentamac on 2/9/26.
//

import Foundation

struct ProductDetailDTO: Decodable {
    let id: Int
    let category: ProductCategory
    let name: String
    let manufacturer: String
    let price: Double
    let currentStock: Int
    let inStock: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case category
        case name
        case manufacturer
        case price
        case currentStock = "current-stock"
        case inStock
    }
}
