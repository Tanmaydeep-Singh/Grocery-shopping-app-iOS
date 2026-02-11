//
//  CategoryProductsView.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//
import SwiftUI

struct CategoryProductsView: View {
    let category: Category
    @State private var showFilter = false;
    @State private var gridLayout: GridLayout = .twoColumn
    @State private var products: [Product] = []
    @State private var isLoading = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
                    .padding(.top, 40)
            }
            LazyVGrid(columns: gridLayout.columns,spacing: 16) {
                ForEach(
                    MockProducts.products
                        /*.filter { $0.category.rawValue == category.title }*/,
                    id: \.id
                ) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        ProductCard(product: product)
                            .frame(width: 180)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .task {
            await loadProducts()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ScreenHeader(title: category.title)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                SwiftUI.Button(action: {
                    showFilter.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color("SearchIcon"))
                }
            }
        }
        .fullScreenCover(isPresented: $showFilter) {
            FilterView()
        }
    }
    func loadProducts() async {
        isLoading = true
        do {
            products = try await NetworkClient.shared
                .request(
                    endpoint: ProductEndpoints
                        .productsByCategory(category: category.value)
                )
        }
        catch {
            errorMessage = "Failed to fetch products." + error.localizedDescription
            print(errorMessage)
        }
        isLoading = false
    }
}
