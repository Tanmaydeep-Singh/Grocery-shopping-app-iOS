import Foundation
import Combine

final class AccountViewModel: ObservableObject {

    @Published var userName: String = "Kushagra"
    @Published var userEmail: String = "hello@gmail.com"

    // MARK: - Menu Items
    let menuItems: [AccountMenuItem] = [
        .init(title: "Orders", icon: "bag"),
        .init(title: "My Details", icon: "person"),
        .init(title: "Delivery Address", icon: "location"),
        .init(title: "Payment Methods", icon: "creditcard"),
        .init(title: "Promo Card", icon: "tag"),
        .init(title: "Notifications", icon: "bell"),
        .init(title: "Help", icon: "questionmark.circle"),
        .init(title: "About", icon: "info.circle")
    ]
}

