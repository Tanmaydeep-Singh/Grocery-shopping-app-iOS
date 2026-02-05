import Foundation

enum ProductCategory: String, Codable, CaseIterable {

    case freshProduce = "fresh-produce"
    case meatSeafood = "meat-seafood"
    case breadBakery = "bread-bakery"
    case dairy
    case candy
    case coffee

    var title: String {
        switch self {
        case .freshProduce: return "Fresh Produce"
        case .meatSeafood: return "Meat & Seafood"
        case .breadBakery: return "Bakery"
        case .dairy: return "Dairy"
        case .candy: return "Candy"
        case .coffee: return "Coffee"
        }
    }
}

