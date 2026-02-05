import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let category: ProductCategory
    let name: String
    let inStock: Bool
}

enum MockProducts {

    static let products: [Product] = [
        Product(id: 1225, category: .freshProduce, name: "Organic Bananas", inStock: true),
        Product(id: 1709, category: .meatSeafood, name: "Beef Bone", inStock: true),
        Product(id: 7395, category: .meatSeafood, name: "Broiler Chicken", inStock: true),
        Product(id: 5477, category: .dairy, name: "Cream Cheese", inStock: true),
        Product(id: 5774, category: .candy, name: "Milk Chocolate", inStock: true)
    ]
    
    static let dummyProduct: Product = Product(id: 1225, category: .freshProduce, name: "Organic Bananas", inStock: true)

    static let categories: [ProductCategory] = ProductCategory.allCases
}

