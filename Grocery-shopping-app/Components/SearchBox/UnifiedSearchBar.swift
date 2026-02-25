//
//  UnifiedSearchBar.swift
//  Nectar
//
//  Created by rentamac on 2/24/26.
//

import SwiftUI

struct UnifiedSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search Store"
    var onSubmit: (() -> Void)? = nil
    var onFiltersApplied: ((Set<String>, Set<String>) -> Void)? = nil
    
    @FocusState private var isFocused: Bool
    @State private var showFilter: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("SearchIcon"))
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .foregroundColor(Color("SearchText"))
                .font(.system(size: 16))
                .submitLabel(.search)
                .autocorrectionDisabled()
                .onSubmit {
                    onSubmit?()
                }
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("SearchIcon"))
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
            }
            
            if onFiltersApplied != nil {
                Button {
                    isFocused = false
                    showFilter = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color("SearchIcon"))
                }
            }
        }
        .padding(16)
        .frame(height: 52)
        .background(Color("SearchBackground"))
        .cornerRadius(16)
        .fullScreenCover(isPresented: $showFilter) {
            if let onFiltersApplied {
                FilterView { categories, brands in
                    onFiltersApplied(categories, brands)
                }
            }
        }
    }
}

#Preview("Without filter") {
    UnifiedSearchBar(text: .constant(""))
        .padding()
}

#Preview("With filter") {
    UnifiedSearchBar(text: .constant("")) { categories, brands in
        print(categories, brands)
    }
    .padding()
}
