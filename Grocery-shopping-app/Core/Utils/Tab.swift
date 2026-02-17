//
//  Tab.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import Combine

enum Tab {
    case home
    case explore
    case cart
    case favourite
    case account
}


final class AppRouter: ObservableObject {
    @Published var selectedTab: Tab = .home
    
    func switchTo(_ tab: Tab) {
        selectedTab = tab
    }
}
