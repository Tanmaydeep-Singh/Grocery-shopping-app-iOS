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
    @State private var goToSuccess = false
    
    let totalCost: Double?
    
    init(totalCost: Double? = nil) {
        self.totalCost = totalCost
    }
    
    private var formattedTotal: String {
        let amount = totalCost ?? 0.0
        return String(format: "$%.2f", amount)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HStack {
                    ScreenHeader(title: "Checkout")
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 16)
                }
                
                Divider()
                    .padding(.bottom, 20)
                
                VStack(spacing: 20) {
                    
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
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    PrimaryButton(title: "Place Order") {
                        goToSuccess = true
                    }
                    .padding(.bottom, 10)
                }
                .padding(.horizontal, 20)
                
                NavigationLink(destination: DeliveryOptionsView(), isActive: $goToDelivery) { EmptyView() }
                NavigationLink(destination: PaymentOptionsView(), isActive: $goToPayment) { EmptyView() }
                NavigationLink(destination: DiscountOptionsView(), isActive: $goToDiscount) { EmptyView() }
                NavigationLink(destination: OrderAcceptedView(), isActive: $goToSuccess) { EmptyView() }
            }
            .padding(.top, 12)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .ignoresSafeArea(edges: .bottom)
            )
            .frame(height: UIScreen.main.bounds.height * 0.55)
        }
    }
}


#Preview {
    NavigationStack {
        CheckoutView()
    }
}


