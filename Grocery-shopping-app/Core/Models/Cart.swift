//
//  Cart.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import Foundation

struct Cart: Codable {
    let id: String
    var items: [CartItem]
}

