//
//  Items.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import Foundation

struct FavouriteItem: Identifiable, Codable {
    let id: Int
    let name: String
    let manufacturer: String
    let price: Double
    let category: ProductCategory
}

extension FavouriteItem {
    var imageName: String {
        category.imageName
    }
}
