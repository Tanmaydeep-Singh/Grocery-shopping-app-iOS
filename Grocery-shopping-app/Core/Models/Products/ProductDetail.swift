//
//  ProductDetail.swift
//  Nectar
//
//  Created by rentamac on 2/9/26.
//

import Foundation

struct ProductDetail {
    let id: Int
    let category: ProductCategory
    let name: String
    let manufacturer: String
    let price: Double
    let currentStock: Int
    let inStock: Bool
    let imageName: String
}

extension ProductDetail {

    init(dto: ProductDetailDTO) {
        self.id = dto.id
        self.category = dto.category
        self.name = dto.name
        self.manufacturer = dto.manufacturer
        self.price = dto.price
        self.currentStock = dto.currentStock
        self.inStock = dto.inStock
        self.imageName = dto.category.imageName
    }
}
