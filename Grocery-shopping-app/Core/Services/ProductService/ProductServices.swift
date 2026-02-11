//
//  ProductServices.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

final class ProductService: ProductServiceProtocol {
    private let networkClient: NetworkClient
    
    // Initializing Network Client
    init(networkClient: NetworkClient = .shared) {
        self.networkClient = networkClient
    }
    
    // Get All Products
    func fetchAllProducts() async throws -> [Product] {
        try await networkClient.request(
            endpoint: ProductEndpoints.allProducts
        )
    }
    
    // Get Product by ID
    func fetchProduct(
        id: String,
        showLabel: Bool = true
    ) async throws -> Product {
        try await networkClient.request(
            endpoint: ProductEndpoints.product(
                id: id,
                showLabel: showLabel
            )
        )
    }
    
    func fetchProductUsingCategory(category: String) async throws -> [Product] {
        try await NetworkClient.shared
            .request(
                endpoint: ProductEndpoints
                    .productsByCategory(category: category)
            )
    }
}
