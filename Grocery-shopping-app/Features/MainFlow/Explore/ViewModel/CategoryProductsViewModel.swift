import Foundation

func getFilterProducts(
    _ categories: Set<String>,
    _ brands: Set<String>,
    searchQuery: String = ""
) async throws -> [Product] {
    let products = try await ProductService().fetchAllProducts()

    let categoryFiltered = categories.isEmpty
        ? products
        : products.filter { categories.contains($0.category.rawValue) }

    let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    guard !query.isEmpty else { return categoryFiltered }

    return categoryFiltered.filter {
        $0.name.lowercased().contains(query) ||
        $0.category.rawValue.lowercased().contains(query)
    }
}
