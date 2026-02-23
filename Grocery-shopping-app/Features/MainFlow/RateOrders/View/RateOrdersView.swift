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
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var rating: Int = 0
    @State private var showSuccessAlert = false
    
    @StateObject private var rateOrderViewModel = RateOrdersViewModel()
    
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
                                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.3))
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
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
                PrimaryButton(title: "Submit Review") {
                    submitReview()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .disabled(rating == 0)
                .opacity(rating == 0 ? 0.6 : 1.0)
            }
            .background(
                LinearGradient(colors: [Color(.systemGroupedBackground).opacity(0), Color(.systemGroupedBackground)], startPoint: .top, endPoint: .bottom)
                    .frame(height: 120)
            )
            
            if showSuccessAlert {
                OrderRatedAlert {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        showSuccessAlert = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        dismiss()
                    }
                }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.6).combined(with: .opacity)
                ))
                .zIndex(1)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Rate Order")
        .navigationBarTitleDisplayMode(.inline)
       
        .task {
            guard let userId = authViewModel.user?.id else {
                print("No user ID found")
                return
            }
            
            if let fetched = await rateOrderViewModel.fetchRating(userId: userId, orderId: order.id) {
                await MainActor.run {
                    print("fetch rating successful: \(fetched)")
                    self.rating = fetched
                }
            }
        }
    }
    
    private func submitReview() {
        Task {
            guard let userId = authViewModel.user?.id else {
                print("No user ID found")
                return
            }
            
            _ = await rateOrderViewModel.updateOrderRating(userId: userId, orderId: order.id, rating: rating)
            await MainActor.run {
                showSuccessAlert = true
            }
        }
    }
}

private extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.separator), lineWidth: 0.5)
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
