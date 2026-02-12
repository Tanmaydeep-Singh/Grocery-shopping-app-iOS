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
    
    // Inside CartProductsService.swift
    func syncCart(products: [Product]) {
        clearCart()
        
        for item in products {
            let cartProduct = CartProduct(context: context)
            cartProduct.id = Int64(item.id)
            cartProduct.name = item.name
            cartProduct.price = item.price ?? 0
            cartProduct.inStock = item.inStock
            cartProduct.imageName = item.imageName
            cartProduct.cartProductId = Int64(item.cartProductId ?? 0)
            cartProduct.quantity = Int64(item.quantity ?? 0)
        }
        
        save()
        print("Core Data: Synced \(products.count) items from server.")
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
