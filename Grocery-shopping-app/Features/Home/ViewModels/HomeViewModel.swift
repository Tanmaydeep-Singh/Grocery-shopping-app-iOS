import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var products: [Product] = []
    
    let sections: [HomeSectionType] = HomeSectionType.allCases
    
    init() {
        products = MockProducts.products
    }
    
    func products(for section: HomeSectionType) -> [Product] {
        switch section {
        case .exclusiveOffer:
            return Array(products.prefix(4))
        case .bestSelling:
            return Array(products.suffix(4))
        case .groceries:
            return products
        }
    }
    
    func products(for category: ProductCategory) -> [Product] {
        products.filter { $0.category == category }
    }
    
    var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return products }
        return products.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}
