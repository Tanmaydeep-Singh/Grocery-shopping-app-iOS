//
//  MapOrderDetailsSheet.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import SwiftUI

struct MapOrderDetailsSheet: View {
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Order #12345")
                    .font(.headline)
                
                Text("Arriving in 12 minutes")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            .padding(.top, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Out for Delivery")
                    .font(.headline)
                
                Text("Your order is on the way")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                ProgressView(value: 0.8)
                    .tint(.green)
            }
            .padding()
            
            
            
            
            HStack(spacing: 14) {
                
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Rahul Sharma")
                        .font(.headline)
                    
                    Text("Delivery Partner")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button {
                    print("Call Rider")
                } label: {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(12)
                        
                }
            }
            .padding()
            
            
            Spacer(minLength: 10)
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
}

#Preview {
    MapOrderDetailsSheet()
}
