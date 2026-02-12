//
//  CartItemView.swift
//  Nectar
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI

struct CartItemView: View {

    let item: Product
    let onIncrease: (Int) -> Void
    let onDecrease: (Int) -> Void
    let onRemove: () -> Void
    @State private var quantity: Int

    init(
            item: Product,
            onIncrease: @escaping (Int) -> Void,
            onDecrease: @escaping (Int) -> Void,
            onRemove: @escaping () -> Void
        ) {
            self.item = item
            self.onIncrease = onIncrease
            self.onDecrease = onDecrease
            self.onRemove = onRemove
            _quantity = State(initialValue: item.quantity ?? 1)
        }

    var body: some View {
        HStack(spacing: 14) {

            Image(item.category.imageName)
                .resizable()
                .scaledToFit()
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
                        quantityButton(icon: "minus", color: .gray) {
                            if quantity > 1 {
                                quantity -= 1
                                onDecrease(quantity)
                            }
                        }

                        Text("\(quantity)")
                            .font(.body)

                        quantityButton(icon: "plus", color: .green) {
                            quantity += 1
                            onIncrease(quantity) 
                        }

                    }

                    Spacer()

                    Text("$\(String(format: "%.2f", (item.price ?? 0.0) * Double(item.quantity ?? 0)))")
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
