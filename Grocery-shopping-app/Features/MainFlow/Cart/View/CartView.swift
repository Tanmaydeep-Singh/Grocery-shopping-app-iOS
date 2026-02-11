//
//  CartView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct CartView: View {

    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                ScrollView {
                    VStack(spacing: 0) {

                        // Header
                        ScreenHeader(
                            title: "My Cart"
                        )

                        Divider()
                            .padding(.bottom, 12)

                        
                        VStack(spacing: 0) {
                            ForEach(viewModel.cartItems.indices, id: \.self) { index in
                                let item = viewModel.cartItems[index]

                                CartItemView(
                                    item: item,
                                    onIncrease: {
                                        viewModel.increaseQuantity(for: item)
                                    },
                                    onDecrease: {
                                        viewModel.decreaseQuantity(for: item)
                                    },
                                    onRemove: {
                                        viewModel.removeItem(item)
                                    }
                                )

                                if index != viewModel.cartItems.count - 1 {
                                    Divider()
                                        .padding(.top, 22)
                                }
                            }
                        }
                        .padding(.horizontal)

                        
                        Color.clear
                            .frame(height: 100)
                    }
                }

                
                if !viewModel.cartItems.isEmpty {
                    checkoutBar
                }
            }
            .background(Color.white)
            .onAppear {
                viewModel.onAppear()
            }
        }
    }

  
    private var checkoutBar: some View {
        PrimaryButton(
            title: "Go To Checkout",
            action: {
                // Navigation later
            }
        )
        .overlay(alignment: .trailing) {
            Text("$\(String(format: "%.2f", viewModel.totalPrice))")
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color("Splash"))
                .cornerRadius(6)
                .foregroundColor(.white)
                .padding(.trailing, 32)
        }
    }
}

#Preview {
    CartView()
}


