//
//  CartView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct CartView: View {

    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                ScrollView {
                    VStack(spacing: 0) {

                        ScreenHeader(title: "My Cart")

                        Divider()
                            .padding(.bottom, 12)

                        VStack(spacing: 0) {
                            ForEach(viewModel.cartItems.indices, id: \.self) { index in
                                let item = viewModel.cartItems[index]

                                cartItemView(item: item)

                                if index != viewModel.cartItems.count - 1 {
                                    Divider()
                                        .padding(.top, 22)
                                }
                            }
                        }
                        .padding(.horizontal)

                        Color.clear
                            .frame(height: 100)
                    }
                }

                if !viewModel.cartItems.isEmpty {
                    checkoutBar
                }
            }
            .background(Color.white)
            .onAppear {
                viewModel.onAppear()
            }
        }
    }

    private func cartItemView(item: CartItem) -> some View {
        HStack(spacing: 14) {

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 76, height: 104)

            VStack(spacing: 14) {

                HStack {
                    Text(item.productName)
                        .font(.body)
                        .fontWeight(.medium)

                    Spacer()

                    Button {
                        viewModel.removeItem(item)
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }

                HStack {
                    Text("\(item.unitDescription), $\(String(format: "%.2f", item.price))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }

                HStack {
                    HStack(spacing: 16) {
                        quantityButton(icon: "minus", color: .gray) {
                            viewModel.decreaseQuantity(for: item)
                        }

                        Text("\(item.quantity)")
                            .font(.body)

                        quantityButton(icon: "plus", color: .green) {
                            viewModel.increaseQuantity(for: item)
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
    }

    private var checkoutBar: some View {
        PrimaryButton(
            title: "Go To Checkout",
            action: {}
        )
        .overlay(alignment: .trailing) {
            Text("$\(String(format: "%.2f", viewModel.totalPrice))")
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color("Splash"))
                .cornerRadius(6)
                .foregroundColor(.white)
                .padding(.trailing, 32)
        }
    }
}

#Preview {
    CartView()
}


