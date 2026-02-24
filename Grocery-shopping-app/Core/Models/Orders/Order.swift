//
//  Order.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation


struct Order: Identifiable {
    var id: String
    var createdOn: Date
    var items: [CartProductDTO]
    var totalPrice: Double
    var rating: Int?
}
