//import Foundation
//import Combine
//
//final class AccountViewModel: ObservableObject {
//
//    @Published var userName: String = "Kushagra"
//    @Published var userEmail: String = "hello@gmail.com"
//
//    // MARK: - Menu Items
//    let menuItems: [AccountMenuItem] = [
//        .init(title: "Orders", icon: "bag"),
//        .init(title: "My Details", icon: "person"),
//        .init(title: "Delivery Address", icon: "location"),
//        .init(title: "Payment Methods", icon: "creditcard"),
//        .init(title: "Promo Card", icon: "tag"),
//        .init(title: "Notifications", icon: "bell"),
//        .init(title: "Help", icon: "questionmark.circle"),
//        .init(title: "About", icon: "info.circle")
//    ]
//}

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

    // MARK: - Init
    init() {
        fetchUserDetails()
    }

    // MARK: - Fetch User
    private func fetchUserDetails() {
        guard let user = Auth.auth().currentUser else {
            userName = "Guest User"
            userEmail = ""
            return
        }

        userEmail = user.email ?? ""

        if let name = user.displayName, !name.isEmpty {
            userName = name
        } else {
            userName = "User"
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            print("User logged out")
        } catch {
            print("Logout failed:", error.localizedDescription)
        }
    }
}


