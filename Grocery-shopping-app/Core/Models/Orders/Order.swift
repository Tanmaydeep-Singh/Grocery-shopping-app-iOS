//
//  Order.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

struct Order: Identifiable, Codable {
    let id: String
    let name: String
    let price: Double
}
