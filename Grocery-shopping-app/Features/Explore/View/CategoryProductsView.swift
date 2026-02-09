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
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout.columns,spacing: 16) {
                ForEach(
                    MockProducts.products
                        /*.filter { $0.category.rawValue == category.title }*/,
                    id: \.id
                ) { product in
                    ProductCard(product: product)
                }
            }
            .padding()
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

}
