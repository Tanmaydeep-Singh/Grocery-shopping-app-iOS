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
    
    private func favoritesRef(userId: String) -> CollectionReference {
        db.collection("users")
            .document(userId)
            .collection("favourites")
    }
    
    func addToFavorites(
        userId: String,
        item: FavouriteItem
    ) async throws {
        
        let docRef = favoritesRef(userId: userId)
            .document(String(item.id))
        
        let data: [String: Any] = [
            "id": item.id,
            "name": item.name,
            "manufacturer": item.manufacturer,
            "price": item.price,
        ]
        
        try await docRef.setData(data)
    }
    
    func getFavorites(userId: String) async throws -> [FavouriteItem] {
        
        let snapshot = try await favoritesRef(userId: userId).getDocuments()
        
        return snapshot.documents.compactMap { document in
            let data = document.data()
            
            guard
                let id = data["id"] as? Int,
                let name = data["name"] as? String,
                let manufacturer = data["manufacturer"] as? String,
                let price = data["price"] as? Double
            else {
                return nil
            }
            
            return FavouriteItem(
                id: id,
                name: name,
                manufacturer: manufacturer,
                price: price,
            )
        }
    }
    
    func removeFromFavorites(
        userId: String,
        productId: Int
    ) async throws {
        
        try await favoritesRef(userId: userId)
            .document(String(productId))
            .delete()
    }
}
