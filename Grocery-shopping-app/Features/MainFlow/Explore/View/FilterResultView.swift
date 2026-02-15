//
//  FilterResultView.swift
//  Nectar
//
//  Created by rentamac on 2/11/26.
//

import SwiftUI

struct FilterResultView: View {
    let selectedCategories: Set<String>
    let selectedBrands: Set<String>
    @State private var gridLayout: GridLayout = .twoColumn
    @State private var products: [Product] = []
    @State private var isLoading = false

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
        .toolbar {
            ToolbarItem(placement: .principal) {
                ScreenHeader(title: "Filtered Products")
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
                selectedBrands
            )
        } catch {
            print(error)
        }
        isLoading = false
    }
}


