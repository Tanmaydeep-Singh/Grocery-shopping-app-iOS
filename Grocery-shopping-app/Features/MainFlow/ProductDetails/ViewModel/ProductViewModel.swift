//
//  ProductViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import Combine

@MainActor
final class ProductViewModel: ObservableObject {
    
    @Published var productDetail: ProductDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isFavorite: Bool = false
    
    private let favoritesService: FavoritesServiceProtocol = FavoritesService()

    
    func fetchProductDetail(productId: Int, userId:  String) async {
        isLoading = true
        errorMessage = nil

        do {
            let dto: ProductDetailDTO = try await NetworkClient.shared.request(endpoint: ProductEndpoints.product(id: String(productId), showLabel: true))
            isFavorite = try await favoritesService.isFavorite(userId: userId, itemId: productId)
            productDetail = ProductDetail(dto: dto)

        }  catch {
            errorMessage = "Failed to load product details"
        }

        isLoading = false
    }
    
    func addToFavorites(userId: String) {
        
        guard let product = productDetail else {
            self.errorMessage = "Product information is missing."
            return
        }

        let item = FavouriteItem(
            id: product.id,
            name: product.name,
            manufacturer: product.manufacturer,
            price: product.price
        )

        Task {
            do {
                try await favoritesService.addToFavorites(userId: userId, item: item)
                print("Successfully added to favorites")
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
}

