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
    
    let categories: [Category] = [
        Category(title: "Fruits & Vegetables",imageName: "fruitsAndVegetables",value: "fresh-produce"),
        Category(title: "Fish & Meat", imageName: "MeatAndFish", value: "meat-seafood"),
        Category(title: "Dairy & Eggs", imageName: "DairyAndEggs", value: "dairy"),
        Category(title: "Cooking Oil & Ghee", imageName: "CookingOilAndGee",value: "coffee"),
        Category(title: "Beverages", imageName: "Beverages", value: "candy"),
        Category(title: "Bakery & Snacks", imageName: "BakeryAndSnacks", value: "bread-bakery")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScreenHeader(title: "Find Products")
                SearchBox()
                
                ScrollView {
                    LazyVGrid(columns: gridLayout.columns, spacing: 16) {
                        ForEach(categories) { category in
                            NavigationLink {
                                CategoryProductsView(category: category)
                            } label: {
                                CategoryCard(
                                    title: category.title,
                                    imageName: category.imageName,
                                    backgroundColor: colors.randomElement()?.uppercased() ?? "FFFFFF"
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
