//
//  APIEndpoint.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

protocol Endpoint {
    //Required
    var path: String { get }
    var method: HTTPMethod { get }
    //Optional
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}


// Default Protocol Implementation
extension Endpoint {
    var queryItems: [URLQueryItem]? { nil }
    var body: Encodable? { nil }
}
