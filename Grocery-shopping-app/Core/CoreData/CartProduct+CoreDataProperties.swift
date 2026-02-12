//
//  CartProduct+CoreDataProperties.swift
//  Nectar
//
//  Created by tanmaydeep on 12/02/26.
//
//

public import Foundation
public import CoreData


public typealias CartProductCoreDataPropertiesSet = NSSet

extension CartProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartProduct> {
        return NSFetchRequest<CartProduct>(entityName: "CartProduct")
    }

    @NSManaged public var id: Int64
    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var inStock: Bool
    @NSManaged public var imageName: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var cartProductId: Int64

}

extension CartProduct : Identifiable {

}
