//
//  CartItemView.swift
//  Nectar
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct CartItemView: View {

    let item: Product
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 14) {

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 76, height: 104)

            VStack(spacing: 14) {

                HStack {
                    Text(item.name)
                        .font(.body)
                        .fontWeight(.medium)

                    Spacer()

                    Button(action: onRemove) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }

                HStack {
                    Text("$\(String(format: "%.2f", item.price ?? 0))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }

                HStack {
                    HStack(spacing: 16) {
                        quantityButton(icon: "minus", color: .gray, action: onDecrease)

                        Text("1")
                            .font(.body)

                        quantityButton(icon: "plus", color: .green, action: onIncrease)
                    }

                    Spacer()

                    Text("$\(String(format: "%.2f", item.price ?? 0))")
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
        }
        .padding(.vertical, 22)
    }

    private func quantityButton(
        icon: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
