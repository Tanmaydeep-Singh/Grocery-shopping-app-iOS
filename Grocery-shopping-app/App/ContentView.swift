//
//  ContentView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab: Tab = .home
    @State private var isLoggedIn: Bool = false
    @State private var path = NavigationPath()
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        if authViewModel.user != nil {
            
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
        else
        {
            NavigationStack(path: $path) {
                       OnboardingView(path: $path)
                           .navigationDestination(for: OnboardingRoutes.self) { route in
                               switch route {
                               case .socialLogin:
                                   SocialLoginView(path: $path)
                               case .login:
                                   LoginView(path: $path)
                                       

                               case .signup:
                                   SignupView(path: $path)
                                
                               case .verification:
                                   VerificationScreen(path: $path)
                               case .location:
                                   LocationView(path: $path, isLoggedIn: $isLoggedIn)
                               }
                           
                           }
                   }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
