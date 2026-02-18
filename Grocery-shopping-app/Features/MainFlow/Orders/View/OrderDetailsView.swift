//
//  OrderDetailsView.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//
import SwiftUI

struct OrderDetailsView: View {
    let order: Order
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Order #\(order.id.suffix(8).uppercased())")
                        .font(.headline)
                    
                    Text(order.createdOn.formatted(date: .long, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            Section(header: Text("Items")) {
                ForEach(order.items) { item in
                    HStack(spacing: 12) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(4)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.body)
                                .fontWeight(.medium)
                            Text("Qty: \(item.quantity)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                            .font(.body)
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Section(header: Text("Payment Summary")) {
                HStack {
                    Text("Total Amount")
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(String(format: "%.2f", order.totalPrice))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
