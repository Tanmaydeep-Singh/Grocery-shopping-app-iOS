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
    
    func fetchProductDetail(productId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let dto: ProductDetailDTO = try await NetworkClient.shared.request(endpoint: ProductEndpoints.product(id: String(productId), showLabel: true))
            
            productDetail = ProductDetail(dto: dto)
        }  catch {
            errorMessage = "Failed to load product details"
        }

        isLoading = false
    }
}

