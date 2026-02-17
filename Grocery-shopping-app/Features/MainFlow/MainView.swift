//
//  MainView.swift
//  Nectar
//
//  Created by tanmaydeep on 07/02/26.
//
//
//  MainView.swift
//  Nectar
//

import SwiftUI
import CoreData

struct MainView: View {

    @StateObject private var router = AppRouter()
    
    @FetchRequest(
        entity: CartProduct.entity(),
        sortDescriptors: []
    )
    private var cartProducts: FetchedResults<CartProduct>
    
    var body: some View {
        TabView(selection: $router.selectedTab) {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)

            NavigationStack {
                ExploreView()
            }
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass")
            }
            .tag(Tab.explore)

            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            .badge(cartProducts.count > 0 ? cartProducts.count : 0)
            .tag(Tab.cart)

            NavigationStack {
                FavouriteView()
            }
            .tabItem {
                Label("Favourite", systemImage: "heart.fill")
            }
            .tag(Tab.favourite)

            NavigationStack {
                AccountView()
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
            .tag(Tab.account)
        }
        .environmentObject(router)
        .tint(.green)
    }
}

#Preview {
    MainView()
}
