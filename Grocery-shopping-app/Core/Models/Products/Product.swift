import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let category: ProductCategory
    let name: String
    let inStock: Bool
    let imageName: String
}

extension Product {
    init(dto: ProductDTO){
        self.id = dto.id
        self.category = dto.category
        self.name = dto.name
        self.inStock = dto.inStock
        self.imageName = dto.category.imageName
    }
}

enum MockProducts {

    static let products: [Product] = [
        Product(id: 1225, category: .freshProduce, name: "Red Apple", inStock: true, imageName: "apple"),
        Product(id: 1709, category: .meatSeafood, name: "Beef Bone", inStock: true, imageName: "boneBeef"),
        Product(id: 7395, category: .meatSeafood, name: "Broiler Chicken", inStock: true, imageName: "broilerChicken"),
        Product(id: 5477, category: .dairy, name: "Cream Cheese", inStock: true, imageName: "cheesyCream"),
        Product(id: 5774, category: .candy, name: "Milk Chocolate", inStock: true, imageName: "milkChocolate")
    ]
    
    static let dummyProduct: Product = Product(id: 1225, category: .freshProduce, name: "Red Apple", inStock: true, imageName: "apple")
}

