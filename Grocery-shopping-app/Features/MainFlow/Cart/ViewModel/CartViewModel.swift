import Foundation
import Combine

//@MainActor
final class CartViewModel: ObservableObject {

    @Published var cartItems: [CartItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: CartServiceProtocol
    private var cartId: String?

    init(service: CartServiceProtocol = CartServiceImpl()) {
        self.service = service
    }

    func onAppear() {
        if cartId == nil {
            createCart()
        }
    }

    private func createCart() {
        isLoading = true

        Task {
            do {
                let cart = try await service.createCart()
                cartId = cart.id
                cartItems = cart.items
            } catch {
                errorMessage = "Failed to create cart"
            }

            isLoading = false
        }
    }

    func increaseQuantity(for item: CartItem) {
        updateQuantity(for: item, newQuantity: item.quantity + 1)
    }

    func decreaseQuantity(for item: CartItem) {
        guard item.quantity > 1 else { return }
        updateQuantity(for: item, newQuantity: item.quantity - 1)
    }

    private func updateQuantity(for item: CartItem, newQuantity: Int) {
        guard let cartId else { return }

        Task {
            do {
                let updatedCart = try await service.updateItemQuantity(
                    cartId: cartId,
                    itemId: item.id,
                    quantity: newQuantity
                )
                cartItems = updatedCart.items
            } catch {
                errorMessage = "Failed to update quantity"
            }
        }
    }

    func removeItem(_ item: CartItem) {
        guard let cartId else { return }

        Task {
            do {
                let updatedCart = try await service.removeItem(
                    cartId: cartId,
                    itemId: item.id
                )
                cartItems = updatedCart.items
            } catch {
                errorMessage = "Failed to remove item"
            }
        }
    }

    var totalPrice: Double {
        cartItems.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }
}
