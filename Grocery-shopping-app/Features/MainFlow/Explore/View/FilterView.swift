//
//  FilterView.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategories: Set<String> = []
    @State private var selectedBrands: Set<String> = []

    let categories = [
        "Fruits & Vegetables",
        "Fish & Meat",
        "Dairy & Eggs",
        "Beverages",
        "Bakery & Snacks"
    ]
    let brands = [
        "Nestlé",
        "Britannia",
        "Amul",
        "ITC",
        "Kellogg’s",
        "PepsiCo",
        "Coca-Cola",
        "Haldiram’s",
        "Parle",
        "MTR"
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    SwiftUI.Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }

                    Spacer()
                }
                .padding(16)

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                                Text("Categories")
                                    .font(.headline)

                                ForEach(categories, id: \.self) { category in
                                    FilterCategoryRow(
                                        title: category,
                                        isSelected: Binding(
                                            get: { selectedCategories.contains(category) },
                                            set: { isChecked in
                                                if isChecked {
                                                    selectedCategories.insert(category)
                                                } else {
                                                    selectedCategories.remove(category)
                                                }
                                            }
                                        )
                                    )
                                }
                            }
                            .padding(16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                                Text("Brands")
                                    .font(.headline)

                        ForEach(brands, id: \.self) { brand in
                                    FilterCategoryRow(
                                        title: brand,
                                        isSelected: Binding(
                                            get: {
                                                selectedBrands
                                                    .contains(brand)
                                            },
                                            set: { isChecked in
                                                if isChecked {
                                                    selectedBrands
                                                        .insert(brand)
                                                } else {
                                                    selectedBrands
                                                        .remove(brand)
                                                }
                                            }
                                        )
                                    )
                                }
                            }
                            .padding(16)
                }
                CommonButton(ButtonText: "Apply Filters") {
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 791)
            .background(
                Color("FilterBackground")
            )
            .clipShape(
                UnevenRoundedRectangle(topLeadingRadius: 30, topTrailingRadius: 30)
            )
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenHeader(title: "Filters")
                }
            }
        }
    }
}

