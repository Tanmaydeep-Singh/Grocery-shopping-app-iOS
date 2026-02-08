//
//  ProductEndpoints.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

enum ProductEndpoints: Endpoint {
    
    // API Cases
    case allProducts
    
    // URL Construction
    var path: String {
            switch self {
            case .allProducts: return "/products"
            }
        }

    // Method Selection
        var method: HTTPMethod { .get }
}
