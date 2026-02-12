//
//  ExploreViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

//
//  ExploreViewModel.swift
//

import Foundation
import Combine
import SwiftUI

final class ExploreViewModel: ObservableObject {
        
    @Published var categories: [Category] = []
    
    
    init() {
        loadCategories()
    }
    
    
    private func loadCategories() {
        categories = ProductCategory
            .allCases
            .map { $0.toCategory() }
    }
}
