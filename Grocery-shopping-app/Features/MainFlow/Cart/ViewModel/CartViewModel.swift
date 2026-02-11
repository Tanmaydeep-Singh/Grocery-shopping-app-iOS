import Foundation
import Combine

@MainActor
final class CartViewModel: ObservableObject {

    @Published var cartItems: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cartService: CartServiceProtocol
    private let productService: ProductServiceProtocol
    private var cartId: String?

    init() {
        self.cartService = CartServices()
        self.productService = ProductService()
    }

    func getCartItem(cartId: String) async  {
        
        do {
            print("CALLED: \(cartId)")
            let cartResp = try await cartService.getCart(cartId: cartId)
            var tempItems: [Product] = []

            print("Res: \(cartResp)")
            
            for product in cartResp.items{
                let product = try await productService.fetchProduct(id: String(product.productId), showLabel: true)
                tempItems.append(product)
            }

            await MainActor.run {
                self.cartItems = tempItems
            }
            print("TEMP ITEMS: \(tempItems)")
        } catch {
            print(error)
        }
        
        
    }
    

    func increaseQuantity() {
    }

    func decreaseQuantity() {
       
    }

    private func updateQuantity() {
    }

    func removeItem() {       
    }

    var totalPrice: Double {
        return 0;
    }
}
