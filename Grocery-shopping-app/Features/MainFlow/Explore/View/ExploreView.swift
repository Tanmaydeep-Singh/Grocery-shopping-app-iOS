//
//  ExploreView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct ExploreView: View {
    @State public var showFilter = false
    @State private var gridLayout: GridLayout = .twoColumn
    @StateObject private var exploreViewModel = ExploreViewModel()
    @State private var navigateToResults = false
    @State private var selectedCategories: Set<String> = []
    @State private var selectedBrands: Set<String> = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScreenHeader(title: "Find Products")
                VStack {
                       SearchBox { categories, brands in
                           selectedCategories = categories
                           selectedBrands = brands
                           navigateToResults = true
                       }
                   }
                   .navigationDestination(isPresented: $navigateToResults) {
                       FilterResultView(
                           selectedCategories: selectedCategories,
                           selectedBrands: selectedBrands
                       )
                   }
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 160), spacing: 16)
                        ],
                        spacing: 16
                    ) {
                        ForEach(exploreViewModel.categories) { category in
                            NavigationLink {
                                CategoryProductsView(category: category)
                            } label: {
                                CategoryCard(
                                    title: category.title,
                                    imageName: category.imageName,
                                    backgroundColor: category.backgroundColor,
                                    borderColor: category.borderColor
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    ExploreView()
}
