//
//  FilterView.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss

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

                // Categories Section
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Categories")
                            .font(.headline)

                        FilterCategoryRow(title: "Fruits & Vegetables")
                        FilterCategoryRow(title: "Fish & Meat")
                        FilterCategoryRow(title: "Dairy & Eggs")
                        FilterCategoryRow(title: "Beverages")
                        FilterCategoryRow(title: "Bakery & Snacks")
                    }
                    .padding(16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Brands")
                            .font(.headline)

                        FilterCategoryRow(title: "Fruits & Vegetables")
                        FilterCategoryRow(title: "Fish & Meat")
                        FilterCategoryRow(title: "Dairy & Eggs")
                        FilterCategoryRow(title: "Beverages")
                        FilterCategoryRow(title: "Bakery & Snacks")
                    }
                    .padding(16)
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

