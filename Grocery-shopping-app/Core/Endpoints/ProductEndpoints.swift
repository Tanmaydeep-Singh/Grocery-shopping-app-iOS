//
//  ProductEndpoints.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

enum ProductEndpoints: Endpoint {

    //API Endpoints
    case allProducts
    case product(
        id: String,
        showLabel: Bool
    )

    // URL Construction
    var path: String {
        switch self {
        case .allProducts:
            return "products"
        case .product(let id, _):
            return "products/\(id)"
        }
    }

    // HTTP Method
    var method: HTTPMethod {
        .get
    }

    // Query Parameters
    var queryItems: [URLQueryItem]? {
        switch self {
        case .product(_, let showLabel):
            return [
                URLQueryItem(
                    name: "product-label",
                    value: String(showLabel)
                )
            ]
        default:
            return nil
        }
    }
}
