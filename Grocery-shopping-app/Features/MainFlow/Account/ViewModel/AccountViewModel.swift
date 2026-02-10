
import Foundation
import Combine
import FirebaseAuth

final class AccountViewModel: ObservableObject {

    // MARK: - User Info
    @Published var userName: String = ""
    @Published var userEmail: String = ""

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


