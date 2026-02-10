import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var products: [Product] = []
    @Published var currentBannerIndex: Int = 0
    @Published var categories: [Category] = []
    @Published var categoryProducts: [Product] = []
    @Published var isLoading: Bool = false
    
    let bannerImages: [String] = [
        "banner_1",
        "banner_2",
        "banner_3"
    ]
    
    let sections: [HomeSectionType] = HomeSectionType.allCases
    
    init() {
//        products = MockProducts.products
//        categoryProducts = MockProducts.products
        loadCategories()
    }
    
    private func loadCategories() {
        categories = ProductCategory
            .allCases
            .map { $0.toCategory() }
    }
    
    // Fetch Products through API
    func fetchProducts(category: ProductCategory? = nil) async {
        isLoading = true;
        do {
            let endpoint: ProductEndpoints = .allProducts

            var dtos: [ProductDTO] =
            try await NetworkClient.shared.request(endpoint: endpoint)

//            // If category filter is applied
//            if let category {
//                dtos = dtos.filter { $0.category == category }
//            }
            if let category{
                categoryProducts = dtos
                    .filter { $0.category == category }
                    .map(Product.init)
            }

            // DTO → UI MODEL (Mapping)
            products = dtos.map(Product.init)

        } catch {
            print("❌ Failed to fetch products:", error)
        }
        isLoading = false;
    }
    
    private var timer: AnyCancellable?
    
    func startBannerAutoScroll() {
           timer = Timer
               .publish(every: 3.5, on: .main, in: .common)
               .autoconnect()
               .sink { [weak self] _ in
                   guard let self else { return }
                   self.advanceBanner()
               }
       }

    func stopBannerAutoScroll() {
        timer?.cancel()
        timer = nil
    }
    
    private func advanceBanner() {
        currentBannerIndex =
        (currentBannerIndex + 1) % bannerImages.count
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
