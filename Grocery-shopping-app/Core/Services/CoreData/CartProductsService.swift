//
//  CartProductsService.swift
//  Nectar
//
//  Created by tanmaydeep on 12/02/26.
//

import Foundation
import CoreData

final class CartProductsService {
    
    static let shared = CartProductsService()
    private let context = PersistenceManager.shared.context
        
    func getProducts() -> [CartProduct] {
        let request : NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
               do {
                           return try context.fetch(request)
                       } catch {
                           print("Failed to fetch recipes:", error.localizedDescription)
                           return []
                       }
       }
    
    private func save() {
           do {
               try context.save()
           } catch {
               print("Save error:", error)
           }
       }

}
