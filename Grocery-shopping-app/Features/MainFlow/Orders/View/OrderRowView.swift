//
//  OrderRowView.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import SwiftUI

struct OrderRowView: View {
    let order: Order
    
    var firstItem: CartProductDTO? {
        order.items.first
    }
    
    var totalQuantity: Int {
        order.items.reduce(0) { $0 + $1.quantity }
    }
    
    var formattedDate: String {
        order.createdOn.formatted(date: .abbreviated, time: .omitted)
    }
    
    var body: some View {
        HStack(spacing: 16) {
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
                Text(firstItem?.name ?? "Order")
                    .font(.headline)
                
                Text("\(totalQuantity) items")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("$\(String(format: "%.2f", order.totalPrice))")
                .font(.headline)
                .bold()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}
