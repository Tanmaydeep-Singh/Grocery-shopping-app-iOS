//
//  RegisterUerRequest.swift
//  Nectar
//
//  Created by tanmaydeep on 09/02/26.
//

import Foundation


struct RegisterUserRequest: Codable {
    let clientName: String
    let clientEmail: String
}
