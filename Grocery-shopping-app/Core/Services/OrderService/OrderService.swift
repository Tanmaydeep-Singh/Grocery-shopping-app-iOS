//
//  OrderService.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import Foundation
import FirebaseFirestore
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
        items: [CartProductDTO],
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
        
        let itemsMap = items.map { item -> [String: Any] in
            return [
                "id": item.id,
                "cartProductId": item.cartProductId,
                "name": item.name,
                "category": item.category,
                "price": item.price,
                "quantity": item.quantity,
                "imageName": item.imageName
            ]
        }
        
        let data: [String: Any] = [
            "id": docRef.documentID,
            "createdOn": Timestamp(date: Date()),
            "items": itemsMap,
            "totalPrice": totalPrice
        ]
        
        try await docRef.setData(data)
        return true
    }
    
    func fetchAllOrders(userId: String) async throws -> [Order] {
        guard !userId.isEmpty else {
            throw NSError(domain: "OrderService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User ID is empty"])
        }
        
        let snapshot = try await ordersRef(userId: userId)
            .order(by: "createdOn", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { document in
            let data = document.data()
            
            let timestamp = data["createdOn"] as? FirebaseFirestore.Timestamp
            let date = timestamp?.dateValue() ?? Date()
            
            let itemsData = data["items"] as? [[String: Any]] ?? []
            
            let orderItems: [CartProductDTO] = itemsData.compactMap { itemData in
                return CartProductDTO(
                    id: itemData["id"] as? Int64 ?? 0,
                    name: itemData["name"] as? String ?? "Unknown Item",
                    price: itemData["price"] as? Double ?? 0.0,
                    quantity: itemData["quantity"] as? Int ?? 0,
                    imageName: itemData["imageName"] as? String ?? "",
                    category: itemData["category"] as? String ?? "General",
                    cartProductId: itemData["cartProductId"] as? Int64 ?? 0
                )
            }
            
            guard
                let id = data["id"] as? String,
                let totalPrice = data["totalPrice"] as? Double
            else { return nil }
            
            return Order(
                id: id,
                createdOn: date,
                items: orderItems,
                totalPrice: totalPrice
            )
        }
    }
    
    // upate user cartId
    func updateUserCartId(userId: String, cartId: String) async throws {
        let db = Firestore.firestore()
        try await db.collection("users").document(userId).updateData([
            "cartId": cartId
        ])

    }
    
    // fetch order by ID
    func fetchOrderById(
        userId: String,
        orderId: String
    ) async throws -> Order {
        
        let db = Firestore.firestore()
        
        let document = try await db
            .collection("users")
            .document(userId)
            .collection("orders")
            .document(orderId)
            .getDocument()
        
        guard let data = document.data() else {
            throw NSError(
                domain: "OrderService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Order not found"]
            )
        }
        
        let timestamp = data["createdOn"] as? FirebaseFirestore.Timestamp
        let date = timestamp?.dateValue() ?? Date()
        
        let itemsData = data["items"] as? [[String: Any]] ?? []
        let orderItems: [CartProductDTO] = itemsData.compactMap { itemData in
            return CartProductDTO(
                id: itemData["id"] as? Int64 ?? 0,
                name: itemData["name"] as? String ?? "Unknown Item",
                price: itemData["price"] as? Double ?? 0.0,
                quantity: itemData["quantity"] as? Int ?? 0,
                imageName: itemData["imageName"] as? String ?? "",
                category: itemData["category"] as? String ?? "General",
                cartProductId: itemData["cartProductId"] as? Int64 ?? 0
            )
        }
        
        guard let totalPrice = data["totalPrice"] as? Double else {
            throw NSError(
                domain: "OrderService",
                code: 500,
                userInfo: [NSLocalizedDescriptionKey: "Invalid order data structure"]
            )
        }
        
        return Order(
            id: data["id"] as? String ?? orderId,
            createdOn: date,
            items: orderItems,
            totalPrice: totalPrice
        )
    }
}
