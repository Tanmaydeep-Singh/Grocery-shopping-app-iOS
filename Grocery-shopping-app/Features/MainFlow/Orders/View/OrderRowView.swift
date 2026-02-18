//
//  OrderRowView.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import SwiftUI

struct OrderRowView: View {
    
    let order: DummyOrder
    
    var firstItem: DummyOrderItem? {
        order.items.first
    }
    
    var totalQuantity: Int {
        order.items.reduce(0) { $0 + $1.quantity }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: order.createdOn)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Product Image (First Item)
            if let imageName = firstItem?.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                
                // First Item Name
                Text(firstItem?.name ?? "Order")
                    .font(.headline)
                
                // Quantity
                Text("\(totalQuantity) items")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Date
                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Price
            Text("₹\(Int(order.totalPrice))")
                .font(.headline)
                .bold()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
