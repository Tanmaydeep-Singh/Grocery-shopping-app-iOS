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
        categories = [
            Category(
                title: "Fruits & Vegetables",
                imageName: "fruitsAndVegetables",
                value: "fresh-produce"
            ),
            
            Category(
                title: "Fish & Meat",
                imageName: "MeatAndFish",
                value: "meat-seafood"
            ),
            
            Category(
                title: "Dairy & Eggs",
                imageName: "DairyAndEggs",
                value: "dairy"
            ),
            
            Category(
                title: "Cooking Oil & Ghee",
                imageName: "CookingOilAndGee",
                value: "cooking-oil"
            ),
            
            Category(
                title: "Beverages",
                imageName: "Beverages",
                value: "beverages"
            ),
            
            Category(
                title: "Bakery & Snacks",
                imageName: "BakeryAndSnacks",
                value: "bread-bakery"
            )
        ]
    }
}
