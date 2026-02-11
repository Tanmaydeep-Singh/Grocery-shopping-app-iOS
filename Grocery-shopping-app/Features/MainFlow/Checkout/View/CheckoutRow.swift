//
//  CheckoutRow.swift
//  Nectar
//
//  Created by rentamac on 2/11/26.
//


import SwiftUI

struct CheckoutRow: View {
    
    let title: LocalizedStringKey
    let value: String?
    let imagePlaceholder: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Spacer()
                
                if let value {
                    Text(value)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                if imagePlaceholder {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 28, height: 28)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.plain)
    }
}
