//
//  CheckoutView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct CheckoutView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var goToDelivery = false
    @State private var goToPayment = false
    @State private var goToDiscount = false
    
    let totalCost: Double?
    let onOrderPlaced: () -> Void   // full screen navigation trigger
    
    private var formattedTotal: String {
        String(format: "$%.2f", totalCost ?? 0)
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Header
            HStack {
                ScreenHeader(title: "Checkout")
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                }
                .padding(.trailing, 16)
            }
            
            Divider()
                .padding(.bottom, 16)
            
            VStack(spacing: 14) {
                
                CheckoutRow(
                    title: "Delivery",
                    value: "Select Method",
                    imagePlaceholder: false
                ) {
                    goToDelivery = true
                }
                
                Divider()
                
                CheckoutRow(
                    title: "Payment",
                    value: nil,
                    imagePlaceholder: true
                ) {
                    goToPayment = true
                }
                
                Divider()
                
                CheckoutRow(
                    title: "Promo Code",
                    value: "Pick Discount",
                    imagePlaceholder: false
                ) {
                    goToDiscount = true
                }
                
                Divider()
                
                CheckoutRow(
                    title: "Total Cost",
                    value: formattedTotal,
                    imagePlaceholder: false
                ) { }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("By placing an order, you agree to our")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text("Terms and Conditions")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 6)
                
                PrimaryButton(title: "Place Order") {
                    onOrderPlaced()
                }
                .padding(.top, 6)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        .background(Color.white)
        
        // Internal navigation inside sheet
        .navigationDestination(isPresented: $goToDelivery) {
            DeliveryOptionsView()
        }
        .navigationDestination(isPresented: $goToPayment) {
            PaymentOptionsView()
        }
        .navigationDestination(isPresented: $goToDiscount) {
            DiscountOptionsView()
        }
    }
}


