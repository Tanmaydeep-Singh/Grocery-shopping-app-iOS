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
    @Published var searchError: String?
    @Published var isSearching: Bool = false
    
    let bannerImages: [String] = [
        "banner_1",
        "banner_2",
        "banner_3"
    ]
    
    let sections: [HomeSectionType] = HomeSectionType.allCases
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadCategories()
        setUpSearchDebounce()
    }
    
    private func loadCategories() {
        categories = ProductCategory
            .allCases
            .map { $0.toCategory() }
    }
    
    private func setUpSearchDebounce() {
        $searchText
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink{ [weak self] value in
                guard let self else { return }
                if !value.isEmpty {
                    Task {
                        await self.searchByCategory(value)
                    }
                } else {
                    self.reserSearch()
                }
            }
            .store(in: &cancellables)
    }
    
    func searchByCategory(_ input: String) async {
        searchError = nil
        
        let normalizedInput = input
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: " ", with: "-")
        
        guard let category = ProductCategory.allCases.first(where: {
            $0.rawValue == normalizedInput ||
            $0.title.lowercased() == input.lowercased()
        }) else {
            isSearching = true
            categoryProducts = []
            searchError = "Invalid category"
            return
        }
        
        isSearching = true
        await fetchProducts(category: category)
    }
    
    func reserSearch(){
        isSearching = false
        searchError = nil
        categoryProducts = []
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
            searchError = error.localizedDescription
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
