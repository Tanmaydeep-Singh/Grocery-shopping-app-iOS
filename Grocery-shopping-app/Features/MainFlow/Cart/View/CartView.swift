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
    
    //Checkout flow variables
    @State private var showCheckout = false
    @State private var goToOrderAccepted = false

    private var cartId: String? {
        authViewModel.user?.cartId
    }
    private var userId: String? {
        authViewModel.user?.id
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 0) {
                        ScreenHeader(title: "My Cart")

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
                                ForEach(cartViewModel.cartItems, id: \.cartProductId) { item in
                                    CartItemView(
                                        item: item,
                                        onIncrease: {
                                            newQuantity in
                                            guard let cartId = authViewModel.user?.cartId else { return }
                                            let id = Int(item.cartProductId)
                                            cartViewModel.updateLocalQuantity(
                                                        itemId: Int(id),
                                                        quantity: newQuantity
                                                    )                                      },
                                        onDecrease: {
                                            newQuantity in
                                            guard let cartId = authViewModel.user?.cartId else { return }
                                            let id = Int(item.cartProductId)
                                                    cartViewModel.updateLocalQuantity(
                                                        itemId: Int(id),
                                                        quantity: newQuantity
                                                    )
                                            
                                        },
                                        onRemove: {
                                            guard let cartId = authViewModel.user?.cartId else { return }
                                            let id = Int(item.cartProductId)

                                            Task {
                                                await cartViewModel.removeItem(
                                                    itemId: Int(id)
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
                guard let cartId else { return }
                await cartViewModel.getCartItem()
            }
        }
    }

    private var checkoutBar: some View {
        PrimaryButton(
            title: "Go To Checkout",
            action: {
                showCheckout = true
            }
        )
        .padding()
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
        .sheet(isPresented: $showCheckout) {
            NavigationStack {
                CheckoutView(
                    totalCost: cartViewModel.totalPrice,
                    onOrderPlaced: {
                        Task {
                            let success = await cartViewModel.createOrder(userId: userId ?? "")
                            if success {
                                showCheckout = false
                                goToOrderAccepted = true
                            } else {
                            }
                        }
                    }                )
            }
            .presentationDetents([.fraction(0.65)])
            .presentationDragIndicator(.hidden)
        }
        .navigationDestination(isPresented: $goToOrderAccepted) {
            OrderAcceptedView()
        }
    }
}


#Preview {
    CartView()
        .environmentObject(AuthViewModel())
}
