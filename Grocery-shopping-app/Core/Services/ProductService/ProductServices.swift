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


}
