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
        ZStack {
            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: gridLayout.columns,spacing: 16) {
                    ForEach(
                        products
                        /*.filter { $0.category.rawValue == category.title }*/,
                        id: \.id
                    ) { product in
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
            .task {
                await loadProducts()
            }
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
            FilterView() { categories, brands in
                Task {
                    do {
                        products = try await getFilterProducts(categories, brands)
                    }
                    catch {
                        print("Error occured while filtering the products", error)
                    }
                }
            }
        }
    }
    func loadProducts() async {
        isLoading = true
        do {
            products = try await ProductService()
                .fetchProductUsingCategory(category: category.value)
        }
        catch {
            errorMessage = "Failed to fetch products." + error.localizedDescription
            print(errorMessage)
        }
        isLoading = false
    }
}

#Preview{
    CategoryProductsView(category: MockProducts.dummyCategory)
}
