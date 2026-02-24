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
    private var cartBackup: [CartBackupItem] = []
    
    func addCartProduct(
        productDetails: ProductDetail? = nil,
        product: Product? = nil,
        cartProductId: Int
    ) {

        if let product = product {

            let cartProduct = CartProduct(context: context)

            cartProduct.id = Int64(product.id)
            cartProduct.name = product.name
            cartProduct.price = 4.99
            cartProduct.inStock = product.inStock
            cartProduct.imageName = product.imageName
            cartProduct.cartProductId = Int64(cartProductId)
            cartProduct.quantity = 1

            save()
            
            return
        }

        if let details = productDetails {

            let cartProduct = CartProduct(context: context)

            cartProduct.id = Int64(details.id)
            cartProduct.name = details.name
            cartProduct.price = details.price
            cartProduct.inStock = details.inStock
            cartProduct.imageName = details.imageName
            cartProduct.cartProductId = Int64(cartProductId)
            cartProduct.quantity = 1
            

            save()
            return
        }

        print("no data")
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
    
    
//    Get Products Count
func getProductsCount() async -> Int {
    let request : NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
           do {
               return try context.fetch(request).count
                   } catch {
                       print(error.localizedDescription)
                       return 0
                   }
   }
    
    // Check if the product is in cart
    func isProductInCart(productId: Int) async -> Bool {
        
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", Int64(productId))
        
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking product existence: \(error)")
            return false
        }
    }
    
    // Get Product by ID:
    func getProductById(productId: Int) async -> CartProduct? {
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %lld", Int64(productId))
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
                        return results.first
        } catch {
            print(error)
            return nil
        }
    }
    
    // Update Product Quantity by ID
    func updateProductQuantity(productId: Int, quantity: Int) async -> EmptyResponse? {
        
        print("CALLED FOR UPDATE: \(productId) \(quantity)")
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        request.predicate = NSPredicate(format: "cartProductId == %lld", Int64(productId))
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            if let product = results.first {

                product.quantity = Int64(quantity)

                try context.save()
            }
    
            return nil
            
        } catch {
            print("CoreData Update Error:", error.localizedDescription)
            return nil
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
    
//    Remove Cart Item
    func removeCartItem(itemId: Int) {
        
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
            request.predicate = NSPredicate(format: "cartProductId == %lld", Int64(itemId))
        
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            try context.save()
            print("Core Data: Item \(itemId) removed successfully.")
        } catch {
            print("error removing item:", error.localizedDescription)
        }
    }
    
    // Inside CartProductsService.swift
    func syncCart(products: [Product]) {
        clearCart()
        
        for item in products {
            print("DETAILS: \(item)")
            let cartProduct = CartProduct(context: context)
            cartProduct.id = Int64(item.id)
            cartProduct.name = item.name
            cartProduct.price = item.price ?? 0
            cartProduct.inStock = item.inStock
            cartProduct.imageName = item.category.imageName
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
    
    func reorder(order: Order) {
        clearCart()
        for item in order.items {
            let cartProduct = CartProduct(context: context)
            
            cartProduct.id = Int64(item.id)
            cartProduct.name = item.name
            cartProduct.price = item.price
            cartProduct.inStock = item.quantity == 0 ? false : true
            cartProduct.imageName = item.imageName
            cartProduct.cartProductId = Int64(Int.random(in: 1000...999999))
            cartProduct.quantity = Int64(item.quantity)
        }
    }
    
    func backupCart() {
        let request: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        
        do {
            let items = try context.fetch(request)
            
            cartBackup = items.map {
                CartBackupItem(
                id: $0.id,
                name: $0.name,
                price: $0.price,
                inStock: $0.inStock,
                imageName: $0.imageName,
                cartProductId: $0.cartProductId,
                quantity: $0.quantity
                )
            }
        } catch {
            print("Backup failed: ", error)
        }
    }
    
    func restoreCartFromBackup() {
        clearCart()
        guard !cartBackup.isEmpty else { return }
        
        for item in cartBackup {
            let cartProduct = CartProduct(context: context)
            
            cartProduct.id = item.id
            cartProduct.name = item.name
            cartProduct.price = item.price
            cartProduct.inStock = item.inStock
            cartProduct.imageName = item.imageName
            cartProduct.cartProductId = item.cartProductId
            cartProduct.quantity = item.quantity
        }
        
        save()
    }
    
    func clearBackup() {
        cartBackup.removeAll()
    }
}
