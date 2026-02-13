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
    @Published var quantity: Int = 1
    @Published var cartProductId: Int?

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
                let res: CartProduct? = await cartProductsService.getProductById(productId: productId)
                self.quantity = Int(res?.quantity ?? 1)
                self.cartProductId = Int(res?.cartProductId ?? 1)
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
            let cartRes = try await cartService.addItem(
                cartId: cartId,
                productId: productId
            )

            if let productDetail = productDetail {

                cartProductsService.addCartProduct(
                    productDetails: productDetail,
                    cartProductId: cartRes.itemId
                )
                self.cartProductId = cartRes.itemId
                self.isInCart = true
                self.quantity = 1
            }

        } catch {
            print("Failed to add item to cart: \(error)")
        }
    }

    
    // Quantity Update with debounce.
    private var debounceTasks: [Int: Task<Void, Never>] = [:]
    
    // Helper func for decounce
    func updateLocalQuantity(cartId: String) {
        if let id = cartProductId {
            debounceTasks[id]?.cancel()
            
            debounceTasks[id] = Task {
                try? await Task.sleep(nanoseconds: 1_500_000_000) //1.5 sec
                
                if Task.isCancelled { return }
                
                await updatedQuantity(
                    cartId: cartId,
                    itemId: id, 
                    quantity: quantity
                )
            }
        }
    }
    
    //Update Item
    func updatedQuantity(
        cartId: String,
        itemId: Int,
        quantity: Int
        
    ) async {
        do {
            _ = await cartProductsService.updateProductQuantity( productId: itemId, quantity: quantity )
            _ = try await cartService.updateItemQuantity(cartId: cartId, productId: String(itemId), quantity: quantity )
        }
        catch {
            print(error)
        }
        
    }
    
    
}

