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

                // MARK: - Scrollable Content
                ScrollView {
                    VStack(spacing: 0) {

                        // Header
                        Text("My Cart")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                            .padding(.bottom, 16)

                        Divider()
                            .padding(.bottom, 12)

                        // Items
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

                        // Space so last item not hidden
                        Color.clear
                            .frame(height: 90)
                    }
                }

                // MARK: - Checkout Bar
                if !viewModel.cartItems.isEmpty {
                    checkoutBar
                }
            }
            .background(Color.white)
        }
    }

    // MARK: - Cart Item Row
    private func cartItemView(item: CartItem) -> some View {
        HStack(spacing: 14) {

            // Image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 76, height: 104)

            VStack(spacing: 14) {

                // Name + remove
                HStack {
                    Text(item.productName)
                        .font(.body)
                        .fontWeight(.medium)

                    Spacer()

                    Button {
                        viewModel.removeItem(item)
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }

                // Unit + price
                HStack {
                    Text("\(item.unitDescription), $\(item.price, specifier: "%.2f")")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }

                // Quantity + final price
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

                    Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
        }
        .padding(.vertical, 22)
    }

    // MARK: - Quantity Button
    private func quantityButton(
        icon: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }

    // MARK: - Checkout Bar
    private var checkoutBar: some View {
        NavigationLink {
            Text("Checkout Screen")
        } label: {
            ZStack {
                Text("Go To Checkout")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                HStack {
                    Spacer()
                    Text("$\(viewModel.totalPrice, specifier: "%.2f")")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(6)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.green)
            .cornerRadius(16)
            .padding()
        }
    }
}

#Preview {
    CartView()
}

    
    




