//
//  NetworkError.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingFailed
}
