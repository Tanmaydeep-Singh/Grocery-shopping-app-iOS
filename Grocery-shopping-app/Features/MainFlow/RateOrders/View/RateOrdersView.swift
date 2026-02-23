//
//  RateOrdersView.swift
//  Nectar
//
//  Created by tanmaydeep on 23/02/26.
//

import SwiftUI

struct RateOrdersView: View {
    let order: Order
    
    @Environment(\.dismiss) var dismiss
    @State private var rating: Int = 0
    @State private var showSuccessAlert = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("How was your shopping experience?")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                        
                        HStack(spacing: 12) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.5))
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            rating = index
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Divider()
                            .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Order Total")
                                .font(.system(size: 13))
                                .foregroundStyle(Color(.secondaryLabel))
                            Spacer()
                            Text("$\(String(format: "%.2f", order.totalPrice))")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                    .cardStyle()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Items")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color(.secondaryLabel))
                            .textCase(.uppercase)
                            .tracking(0.5)
                            .padding([.horizontal, .top], 16)
                            .padding(.bottom, 12)
                        
                        ForEach(Array(order.items.enumerated()), id: \.element.id) { index, item in
                            if index > 0 { Divider().padding(.horizontal, 16) }
                            HStack(spacing: 12) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .padding(6)
                                    .background(Color(.systemGroupedBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(item.name)
                                        .font(.system(size: 14, weight: .medium))
                                    Text("Qty: \(item.quantity)")
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(.tertiaryLabel))
                                }
                                Spacer()
                                Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                    }
                    .cardStyle()
                    

                    Color.clear.frame(height: 100)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            
            VStack {
                Spacer()
                PrimaryButton(title: "Submit Review") {
                    submitReview()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
            .disabled(rating == 0)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Rate Order")
        .navigationBarTitleDisplayMode(.inline)
        .alert( Text("Review Submitted!")
            .font(.system(size: 20, weight: .bold)), isPresented: $showSuccessAlert) {
            Button("OK") { dismiss() }
        } message: {
           
                                    
                                    Text("Thanks for sharing your experience. It helps us improve Nectar for you.")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
        }
    }
    
    private func submitReview() {
        showSuccessAlert = true
    }
}

private extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.separator), lineWidth: 1)
            )
    }
}

#Preview {
    NavigationStack {
        RateOrdersView(order: Order(
            id: "ORD-9921",
            createdOn: Date(),
            items: [
                CartProductDTO(
                    id: 1,
                    name: "1/2 in. Brushless Hammer Drill",
                    price: 4.99,
                    quantity: 2,
                    imageName: "pulses",
                    category: "General",
                    cartProductId: 101
                ),
                CartProductDTO(
                    id: 1,
                    name: "1/2 in. Brushless Hammer Drill",
                    price: 4.99,
                    quantity: 2,
                    imageName: "pulses",
                    category: "General",
                    cartProductId: 101
                ),CartProductDTO(
                    id: 1,
                    name: "1/2 in. Brushless Hammer Drill",
                    price: 4.99,
                    quantity: 2,
                    imageName: "pulses",
                    category: "General",
                    cartProductId: 101
                )
            ],
            totalPrice: 12.98
        ))
    }
}
