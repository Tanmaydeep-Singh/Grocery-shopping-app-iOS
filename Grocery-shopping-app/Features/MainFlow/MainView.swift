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
    
    @State private var showFloatingBar = true
    @State private var showDeliveryTracking = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
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
                
                if showFloatingBar  && router.selectedTab == .home {
                    DeliveryFloatingBar(
                        state: .outForDelivery,
                        startDate: .now,
                        estimatedEndDate: .now.addingTimeInterval(600)
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 70)
                    .onTapGesture {
                        showDeliveryTracking = true
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .navigationDestination(isPresented: $showDeliveryTracking) {
                DeliveryTrackingView(
                    locationManager: LocationManager()
                )
            }
        }
        .environmentObject(router)
        .tint(.green)
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel())
}
