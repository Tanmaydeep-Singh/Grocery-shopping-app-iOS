//
//  Cart.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import Foundation

struct Cart: Codable {
    let created: String
    var items: [CartItem]
}

