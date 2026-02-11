//
//  CartView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 0) {
                        ScreenHeader(title: "My Cart.")

                        Divider()
                            .padding(.bottom, 12)

                        if cartViewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            .frame(minHeight: 400)
                        } else if cartViewModel.cartItems.isEmpty {
                            VStack {
                                Spacer()
                                Text("Cart is empty.")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .frame(minHeight: 400)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(cartViewModel.cartItems) { item in
                                    CartItemView(
                                        item: item,
                                        onIncrease: { cartViewModel.increaseQuantity() },
                                        onDecrease: { cartViewModel.decreaseQuantity() },
                                        onRemove: {
                                            guard let cartID = authViewModel.user?.cartId,
                                            let cartProductId = item.cartProductId else { return }

                                            Task {
                                                await cartViewModel.removeItem(
                                                    cartId: cartID,
                                                    itemId: cartProductId
                                                )
                                            }
                                        }
                                    )

                                    if item.id != cartViewModel.cartItems.last?.id {
                                        Divider()
                                            .padding(.top, 22)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        Color.clear
                            .frame(height: 100)
                    }
                }

                if !cartViewModel.cartItems.isEmpty {
                    checkoutBar
                }
            }
            .background(Color.white)
            .task {
                guard let cartID = authViewModel.user?.cartId else { return }
                await cartViewModel.getCartItem(cartId: cartID)
            }
        }
    }

    private var checkoutBar: some View {
        PrimaryButton(
            title: "Go To Checkout",
            action: { }
        )
        .overlay(alignment: .trailing) {
            Text("$\(String(format: "%.2f", cartViewModel.totalPrice))")
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
        .environmentObject(AuthViewModel())
}
