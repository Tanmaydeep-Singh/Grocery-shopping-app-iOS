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
    let cartId: String?
}
