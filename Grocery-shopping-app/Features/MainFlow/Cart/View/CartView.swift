//
//  CartView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
import CoreLocation

struct CartView: View {
    var onOrderPlaced: (() -> Void)?
    @StateObject private var cartViewModel = CartViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    //Checkout flow variables
    @State private var showCheckout = false
    @State private var goToOrderAccepted = false
    
    //Location Manager:
    @StateObject private var locationManager = LocationManager()

    @State private var showPermissionAlert = false
    

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
                    
                    let status = locationManager.authorizationStatus
                    
                    if status == .authorizedWhenInUse || status == .authorizedAlways {
                        
                        if locationManager.userCoordinate != nil {
                            showCheckout = true
                        } else {
                            locationManager.requestLocation()
                        }
                        
                    } else if status == .denied || status == .restricted {
                        
                        print("ACCESS DENIED")
                        showPermissionAlert = true

                        
                    } else {
                        
                        locationManager.checkPermissionAndRequest()
                    }
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
                                onOrderPlaced?()
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
        .alert("Location Permission Required", isPresented: $showPermissionAlert) {
            
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            
            Button("Cancel", role: .cancel) { }
            
        } message: {
            Text("Please enable location access in Settings to proceed to checkout.")
        }
    }
}


#Preview {
    CartView()
        .environmentObject(AuthViewModel())
}
