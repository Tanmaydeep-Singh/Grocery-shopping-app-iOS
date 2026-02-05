import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let category: String
    let name: String
    let inStock: Bool
}

enum MockProduct {

    static let products: [Product] = [
        Product(id: 1225, category: "fresh-produce", name: "Organic Bananas", inStock: true),
        Product(id: 1709, category: "meat-seafood", name: "Beef Bone", inStock: true),
        Product(id: 7395, category: "meat-seafood", name: "Broiler Chicken", inStock: true),
        Product(id: 5477, category: "dairy", name: "Cream Cheese", inStock: true),
        Product(id: 5774, category: "candy", name: "Milk Chocolate", inStock: true)
    ]

    static let categories: [Category] = [
        Category(title: "Pulses", slug: "pulses"),
        Category(title: "Rice", slug: "rice"),
        Category(title: "Meat", slug: "meat-seafood"),
        Category(title: "Dairy", slug: "dairy")
    ]
}
