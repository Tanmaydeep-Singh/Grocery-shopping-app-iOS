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
    @State private var filtered: String? = nil
    @State private var navigateToResults = false
    @State private var selectedCategories: Set<String> = []
    @State private var selectedBrands: Set<String> = []
    
    var body: some View {
            ScrollView {
                if isLoading {
                    ProgressView()
                        .padding(.top, 40)
                }
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
        
        .navigationDestination(isPresented: $navigateToResults) {
            FilterResultView(
                selectedCategories: selectedCategories,
                selectedBrands: selectedBrands
            )
        }
        .task {
            await loadProducts()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ScreenHeader(title: filtered ?? category.title)
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
                selectedCategories = categories
                selectedBrands = brands
                navigateToResults = true
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
