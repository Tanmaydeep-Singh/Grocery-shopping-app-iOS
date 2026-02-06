import SwiftUI
internal import Combine

@MainActor
final class CartViewModel: ObservableObject {

    // MARK: - Published State
    @Published var cartItems: [CartItem] = []

    // MARK: - Init (load dummy cart)
    init() {
        loadDummyCart()
    }

    // MARK: - Dummy Data
    private func loadDummyCart() {
        cartItems = [
            CartItem(
                id: "1",
                productName: "Bell Pepper Red",
                productImageURL: "",
                unitDescription: "1kg",
                price: 4.99,
                quantity: 2
            ),
            CartItem(
                id: "2",
                productName: "Egg Chicken Red",
                productImageURL: "",
                unitDescription: "4pcs",
                price: 1.99,
                quantity: 3
            ),
            CartItem(
                id: "3",
                productName: "Organic Bananas",
                productImageURL: "",
                unitDescription: "12kg",
                price: 3.00,
                quantity: 1
            ),
            CartItem(
                id: "4",
                productName: "Ginger",
                productImageURL: "",
                unitDescription: "250gm",
                price: 2.99,
                quantity: 2
            )
        ]
    }

    // MARK: - Actions
    func increaseQuantity(for item: CartItem) {
        updateQuantity(for: item, delta: 1)
    }

    func decreaseQuantity(for item: CartItem) {
        guard item.quantity > 1 else { return }
        updateQuantity(for: item, delta: -1)
    }

    private func updateQuantity(for item: CartItem, delta: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        cartItems[index].quantity += delta
    }

    func removeItem(_ item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }

    // MARK: - Total
    var totalPrice: Double {
        cartItems.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }
}
