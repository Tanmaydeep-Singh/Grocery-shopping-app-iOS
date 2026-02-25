//
//  MapOrderDetailsSheet.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import SwiftUI

struct MapOrderDetailsSheet: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Order #12345")
                .font(.headline)
            
            Text("Arriving in 12 minutes")
                .font(.subheadline)
                .foregroundColor(.green)
            
            Divider()
            
            HStack {
                Image(systemName: "bicycle")
                Text("Rider: Rahul Sharma")
            }
            
            HStack {
                Image(systemName: "phone.fill")
                Text("Call Rider")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    MapOrderDetailsSheet()
}
