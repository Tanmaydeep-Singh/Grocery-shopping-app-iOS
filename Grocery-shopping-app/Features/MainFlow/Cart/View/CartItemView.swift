//
//  CartItemView.swift
//  Nectar
//
//  Created by rentamac on 2/10/26.
//
import SwiftUI

struct CartItemView: View {
    @ObservedObject var item: CartProduct
    
    let onIncrease: (Int) -> Void
    let onDecrease: (Int) -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Image(item.imageName ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 76, height: 104)

            VStack(spacing: 14) {
                HStack {
                    Text(item.name ?? "Unknown Product")
                        .font(.body)
                        .fontWeight(.medium)

                    Spacer()

                    Button(action: onRemove) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }

                HStack {
                    Text("$\(String(format: "%.2f", item.price))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }

                HStack {
                    HStack(spacing: 16) {
                        quantityButton(icon: "minus", color: .gray) {
                            if item.quantity > 1 {
                                onDecrease(Int(item.quantity) - 1)
                            }
                            else if(item.quantity == 1) {
                                onRemove()
                            }
                        }

                        Text("\(item.quantity)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(minWidth: 25)

                        quantityButton(icon: "plus", color: .green) {
                            onIncrease(Int(item.quantity) + 1)
                        }
                    }

                    Spacer()

                    Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
        }
        .padding(.vertical, 22)
    }

    // Professional reusable button component
    private func quantityButton(
        icon: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
