//
//  DeliveryFloatingBar.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import SwiftUI

struct DeliveryFloatingBar: View {
    
    let state: NectarDeliveryLiveActivityAttributes.DeliveryState
    let startDate: Date
    let estimatedEndDate: Date?
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 8) {
                
                switch state {
                    
                case .preparing:
                    
                    Text("Preparing your order")
                        .font(.headline)
                    
                    Text("We are preparing your order")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ProgressView()
                        .progressViewStyle(.linear)
                        .tint(Color("Splash"))
                    
                case .outForDelivery:
                    
                    Text("Out for Delivery")
                        .font(.headline)
                    
                    Text("Your order is on the way")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if let endDate = estimatedEndDate {
                        ProgressView(
                            timerInterval: startDate...endDate,
                            countsDown: true
                        )
                        .progressViewStyle(.linear)
                        .tint(Color("Splash"))
                    }
                    
                case .delivered:
                    
                    Text("🎉 Order Delivered")
                        .font(.headline)
                    
                    Text("Enjoy your groceries!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .shadow(radius: 8)
    }
}

#Preview("Preparing") {
    DeliveryFloatingBar(
        state: .outForDelivery,
        startDate: .now,
        estimatedEndDate: .now.addingTimeInterval(600)
    )
    .padding()
}
