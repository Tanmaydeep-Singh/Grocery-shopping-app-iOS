import SwiftUI

struct FilterResultView: View {
    let selectedCategories: Set<String>
    let selectedBrands: Set<String>
    var searchQuery: String = ""

    @State private var gridLayout: GridLayout = .twoColumn
    @State private var products: [Product] = []
    @State private var isLoading = false

    private var navigationTitle: String {
        searchQuery.isEmpty ? "Filtered Products" : "Results for \"\(searchQuery)\""
    }

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
                    .padding(.top, 40)
            } else if products.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "cart.badge.questionmark")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No products found")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Try changing filters or search term")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.7))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
            } else {
                LazyVGrid(columns: gridLayout.columns, spacing: 16) {
                    ForEach(products, id: \.id) { product in
                        NavigationLink {
                            ProductDetailView(productId: product.id)
                        } label: {
                            ProductCard(product: product)
                                .frame(width: 180)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ScreenHeader(title: navigationTitle)
            }
        }
        .task {
            await loadFilteredProducts()
        }
    }

    func loadFilteredProducts() async {
        isLoading = true
        do {
            products = try await getFilterProducts(
                selectedCategories,
                selectedBrands,
                searchQuery: searchQuery
            )
        } catch {
            print(error)
        }
        isLoading = false
    }
}
