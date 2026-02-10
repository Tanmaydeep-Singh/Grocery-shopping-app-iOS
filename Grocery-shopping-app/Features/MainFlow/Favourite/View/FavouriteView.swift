//
//  FavouriteView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = FavouriteViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Text("My Favourites")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        .padding(.bottom, 16)

                    Divider()

                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else if viewModel.favouriteItems.isEmpty {
                        Spacer()
                        Text("No favourites yet")
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.favouriteItems) { item in
                                    favouriteItemRow(item: item)
                                    Divider()
                                }
                            }
                            .padding(.horizontal)
                            
                            Color.clear.frame(height: 90)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    PrimaryButton(title: "Add to cart") {
                        // Action
                    }
                    .padding(.bottom, 10)
                }
            }
            .background(Color.white)
            .task {
                let userId = authViewModel.user?.id ?? ""
                await viewModel.loadFavorites(userId: userId)
            }
        }
    }

    private func favouriteItemRow(item: FavouriteItem) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 76, height: 104)

            VStack(spacing: 10) {
                HStack {
                    Text(item.name)
                        .font(.body)
                        .fontWeight(.medium)
                    Spacer()
                }

                HStack {
                    Text(item.manufacturer)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }

            Spacer()

            HStack(spacing: 8) {
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.body)
                    .fontWeight(.medium)

                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 22)
    }
}

#Preview {
    FavouriteView()
        .environmentObject(AuthViewModel())
}
