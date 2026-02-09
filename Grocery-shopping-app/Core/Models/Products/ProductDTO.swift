//
//  ProductDTO.swift
//  Nectar
//
//  Created by rentamac on 2/9/26.
//

import Foundation

struct ProductDTO: Identifiable, Codable {
    let id: Int
    let category: ProductCategory
    let name: String
    let inStock: Bool
}
