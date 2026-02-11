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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScreenHeader(title: "Find Products")
                SearchBox()
                
                ScrollView {
                    LazyVGrid(columns: gridLayout.columns, spacing: 16) {
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
