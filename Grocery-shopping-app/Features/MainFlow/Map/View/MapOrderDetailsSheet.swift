//
//  MapOrderDetailsSheet.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import SwiftUI
import SwiftUI

struct MapOrderDetailsSheet: View {
    
    @StateObject private var deliveryStore = DeliveryStateStore.shared
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(alignment: .leading, spacing: 24) {
                
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Order #12345")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                        
                        Text("Arriving in 12 minutes")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, 10)

                VStack(alignment: .leading, spacing: 12) {
                    OrderStatus(
                        state: deliveryStore.state!,
                        startDate: deliveryStore.startDate ?? .now,
                        estimatedEndDate: deliveryStore.estimatedEndDate
                    )
                }
                
                Divider()

                HStack(spacing: 16) {
                    ZStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 52, height: 52)
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Circle()
                            .fill(.green)
                            .frame(width: 14, height: 14)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .offset(x: 18, y: 18)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Rahul Sharma")
                            .font(.headline)
                        
                        Label("4.9 ★ Delivery Partner", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .symbolRenderingMode(.multicolor)
                    }
                    
                    Spacer()
                    
                    Button {
                        print("Call Rider")
                    } label: {
                        Image(systemName: "phone.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(
                                Circle()
                                    .fill(LinearGradient(colors: [.green, .green.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                            )
                            .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 30)
                        
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom)

    }
}

#Preview {
    MapOrderDetailsSheet()
}
