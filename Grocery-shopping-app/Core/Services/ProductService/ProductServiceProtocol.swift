//
//  ProductServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation


protocol ProductServiceProtocol {
    func fetchAllProducts() async throws -> [Product]
    func fetchProduct(id: String, showLabel: Bool) async throws -> Product
}
