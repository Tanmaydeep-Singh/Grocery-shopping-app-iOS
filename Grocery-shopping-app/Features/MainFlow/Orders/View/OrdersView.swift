//
//  OrdersView.swift
//  Nectar
//
//  Created by tanmaydeep on 18/02/26.
//

import SwiftUI

struct OrdersView: View {
    
    let orders = DummyOrder.sampleOrders

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                ForEach(orders) { order in
                    OrderRowView(order: order)
                }
            }
            .padding()
        }
        .navigationTitle("My Orders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)

    }
}

#Preview {
    OrdersView()
}
