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
    @Published var isInCart: Bool = false
    @Published var quantity : Int = 1
    
    private let favoritesService: FavoritesServiceProtocol = FavoritesService()
    private let cartService: CartServiceProtocol = CartServices()
    private let cartProductsService: CartProductsService = CartProductsService()

    
    func fetchProductDetail(productId: Int, userId:  String) async {
        isLoading = true
        errorMessage = nil

        do {
            let dto: ProductDetailDTO = try await NetworkClient.shared.request(endpoint: ProductEndpoints.product(id: String(productId), showLabel: true))
            isFavorite = try await favoritesService.isFavorite(userId: userId, itemId: productId)
            isInCart = await cartProductsService.isProductInCart(productId: productId)
            if isInCart {
                quantity = await Int(cartProductsService.getProductById(productId: productId)?.quantity ?? 1)
            }
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
            price: product.price,
            category: product.category,
        )

        Task {
            do {
                try await favoritesService.addToFavorites(userId: userId, item: item)
                isFavorite = true
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func removeFromFavorite(userId: String){
        
        guard let product = productDetail else {
            self.errorMessage = "Product information is missing."
            return
        }

        Task {
            do {
                try await favoritesService.removeFromFavorites(userId: userId, productId: product.id)
                isFavorite = false
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
    
    
    // Add item to cart:
    func addToCart(cartId: String) async {
        
        guard let productId = productDetail?.id else {
            print("Error: Product ID is missing")
            return
        }

        do {
            print("Product Details  : \(String(describing: productDetail))")
           let cartRes = try await cartService.addItem(cartId: cartId, productId: productId)
            
            print("cartRes : \(cartRes)")
            if let productDetail = productDetail {
                cartProductsService.addCartProduct(productDetails: productDetail, cartProductId: cartRes.itemId)
            }
            
        } catch {
            print("Failed to add item to cart: \(error)")
        }
    }
    
    // Quantity Update with debounce.
    
    
}

