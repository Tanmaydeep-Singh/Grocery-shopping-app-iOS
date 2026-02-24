import Foundation
import Combine

@MainActor
final class OrdersViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let ordersService: OrderServiceProtocol
    
    init() {
        self.ordersService = OrderService()
    }
    
    func fetchOrders(userId: String) async {
        guard !userId.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            print("Called to fetch order...")
            self.orders = try await ordersService.fetchAllOrders(userId: userId)
            print("Called to fetch order... \(self.orders.count)")

            isLoading = false
        } catch {
            self.errorMessage = "Failed to fetch orders: \(error.localizedDescription)"
            isLoading = false
        }
    }
}



