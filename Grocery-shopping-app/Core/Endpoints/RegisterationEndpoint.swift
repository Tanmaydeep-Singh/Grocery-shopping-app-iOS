//
//  RegisterationEndpoint.swift
//  Nectar
//
//  Created by tanmaydeep on 09/02/26.
//

import Foundation

enum RegisterationEndpoint: Endpoint {

    case register(RegisterUserRequest)

    var path: String {
        return "api-clients"
    }

    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        }
    }
    
    var body: Data? {
            switch self {
            case .register(let userRequest):
                return try? JSONEncoder().encode(userRequest)
            }
        }

}
