//
//  User.swift
//  Nectar
//
//  Created by tanmaydeep on 05/02/26.
//

import Foundation


struct User : Codable {
    let id: String
    let email: String
    let username: String
    let token: String?
}

struct FavouriteItem: Identifiable, Codable {
    let id: Int
    let name: String
    let manufacturer: String
    let price: Double
}
