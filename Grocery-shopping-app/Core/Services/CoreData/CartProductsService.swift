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
    
//    Create CartProduct
    func addCartProduct( product: ProductDetail , cartProductId: Int) {
        
        do {
            
            print("Adding to cart: \(product)")
            print(" cartProductId: \(cartProductId)")
            
            let cartProduct = CartProduct(context: context)
            
            cartProduct.id = Int64(product.id)
            cartProduct.name = product.name
            cartProduct.price = product.price
            cartProduct.inStock = product.inStock
            cartProduct.imageName = product.imageName
            cartProduct.cartProductId = Int64(cartProductId)
            cartProduct.quantity = 1
            
            save()
        }
        catch {
            print("ERRRRR : \(error)")
        }
    }

        
//    Get Products
    func getProducts() async -> [CartProduct] {
        let request : NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
               do {
                           return try context.fetch(request)
                       } catch {
                           print("Failed to fetch recipes:", error.localizedDescription)
                           return []
                       }
       }
    
    // Clear coredata
    func clearCart() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CartProduct.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest) as? [NSManagedObject]
            items?.forEach { context.delete($0) }
            
            try context.save()
            print("Core Data: Cart cleared successfully.")
        } catch {
            print("Error clearing cart: \(error.localizedDescription)")
        }
    }
    
    
    // Helper Save fun
    private func save() {
           do {
               try context.save()
           } catch {
               print("Save error:", error)
           }
       }

}
