//
//  HomeView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HomeHeaderView()
                SearchBarView(text: $viewModel.searchText)
                OfferBannerView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    HomeView()
}
