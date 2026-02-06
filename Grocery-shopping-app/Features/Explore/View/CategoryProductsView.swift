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
    
    var body: some View {
        VStack {
            ScreenHeader(title: "show product list here")
            Spacer()
            
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
