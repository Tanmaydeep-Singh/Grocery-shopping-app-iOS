//
//  OrderService.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import Foundation
import FirebaseFirestore

final class OrderService: OrderServiceProtocol {
    
    private let db = Firestore.firestore()
    
    private func ordersRef(userId: String) -> CollectionReference {
        
        db.collection("users")
            .document(userId)
            .collection("orders")
    }
    
    func createOrder(
        userId: String,
        items: [CartProduct],
        totalPrice: Double
    
    ) async throws -> Bool {
        
        guard !userId.isEmpty else {
            throw NSError(
                domain: "OrderService",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "User ID is empty"]
            )
        }
        
        let docRef = ordersRef(userId: userId).document()
        
        
        let data: [String: Any] = [
            "id": docRef.documentID,
            "createdOn": Timestamp(date: Date()),
            "items": items,
            "totalPrice": totalPrice
        ]
        
       try await docRef.setData(data)
    
        return true
    }
    
    func fetchAllOrders(userId: String) async throws -> [Order] {
        
        guard !userId.isEmpty else {
            throw NSError(
                domain: "OrderService",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "User ID is empty"]
            )
        }
        
        let snapshot = try await ordersRef(userId: userId)
            .order(by: "createdOn", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { document in
            let data = document.data()
            
            guard
                let id = data["id"] as? String,
                let createdOn = data["createdOn"] as? Date,
                let items = data["items"] as? [CartProduct],
                let totalPrice = data["totalPrice"] as? Double
            else{
                return nil
            }
            
            return Order(
                id: id,
                createdOn: createdOn,
                items: items,
                totalPrice: totalPrice
            )
            
        }
    }
    
  
}

