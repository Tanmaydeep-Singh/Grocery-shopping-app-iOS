//
//  FavouriteView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct FavouriteView: View {

    @StateObject private var viewModel = FavouriteViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 0) {
                        
                        // Header
                        Text("My Favourites")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                            .padding(.bottom, 16)
                        
                        Divider()
                            .padding(.bottom, 12)
                        
                        // Favourite items
                        VStack(spacing: 0) {
                            ForEach(viewModel.favouriteItems.indices, id: \.self) { index in
                                let item = viewModel.favouriteItems[index]
                                
                                favouriteItemRow(item: item)
                                
                                if index != viewModel.favouriteItems.count - 1 {
                                    Divider()
                                        .padding(.top, 22)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Space for bottom CTA
                        Color.clear
                            .frame(height: 90)
                    }
                }
                
                PrimaryButton(title:"Add to cart"){
                }
            }
            
            .background(Color.white)
        }
    }

    // Favourite Item Row
    private func favouriteItemRow(item: CartItem) -> some View {
        HStack(spacing: 14) {

            // Image placeholder (same size as Cart)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 76, height: 104)

            // Product info
            VStack(spacing: 10) {

                HStack {
                    Text(item.productName)
                        .font(.body)
                        .fontWeight(.medium)

                    Spacer()
                }

                HStack {
                    Text("\(item.unitDescription), Price")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }
            }

            Spacer()

            // Price + chevron
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
}
