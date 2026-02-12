//
//  FavoritesService.swift
//  Nectar
//
//  Created by tanmaydeep on 10/02/26.
//

import Foundation
import FirebaseFirestore

final class FavoritesService: FavoritesServiceProtocol {
    
    private let db = Firestore.firestore()
    
    // Create ref to user
    private func favoritesRef(userId: String) -> CollectionReference {
        
        db.collection("users")
            .document(userId)
            .collection("favourites")
    }
    
    // Add to favorites
    func addToFavorites(
        userId: String,
        item: FavouriteItem
    ) async throws {
        
        guard !userId.isEmpty else {
                throw NSError(domain: "FavoritesService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User ID is empty"])
            }
        
        let docRef = favoritesRef(userId: userId)
            .document(String(item.id))
        
        let data: [String: Any] = [
            "id": item.id,
            "name": item.name,
            "manufacturer": item.manufacturer,
            "price": item.price,
            "category": item.category.rawValue
        ]
        
        try await docRef.setData(data)
    }
    
    // Get favoriteTask 15: "Unsupported type: __SwiftValue (found in field category)"
    func getFavorites(userId: String) async throws -> [FavouriteItem] {
        
        let snapshot = try await favoritesRef(userId: userId).getDocuments()
        
        return snapshot.documents.compactMap { document in
            let data = document.data()
            
            guard
                let id = data["id"] as? Int,
                let name = data["name"] as? String,
                let manufacturer = data["manufacturer"] as? String,
                let price = data["price"] as? Double,
                let categoryRaw = data["category"] as? String,
                let category = ProductCategory(rawValue: categoryRaw)
            else {
                return nil
            }
            
            return FavouriteItem(
                id: id,
                name: name,
                manufacturer: manufacturer,
                price: price,
                category: category,
            )
        }
    }
    
    // Remove from favorite
    func removeFromFavorites(
        userId: String,
        productId: Int
    ) async throws {
        
        try await favoritesRef(userId: userId)
            .document(String(productId))
            .delete()
    }
    
    // check if the item is favorite.
    func isFavorite(
        userId: String,
        itemId: Int
    ) async throws -> Bool {
        
        let document = try await favoritesRef(userId: userId)
            .document(String(itemId))
            .getDocument()
        
        return document.exists
    }

}
