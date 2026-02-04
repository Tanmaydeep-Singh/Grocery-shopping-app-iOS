//
//  ContentView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(Tab.explore)

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(Tab.cart)

            FavouriteView()
                .tabItem {
                    Label("Favourite", systemImage: "heart.fill")
                }
                .tag(Tab.favourite)

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(Tab.account)
        }.tint(.green) 
    }
}

#Preview {
    ContentView()
}
