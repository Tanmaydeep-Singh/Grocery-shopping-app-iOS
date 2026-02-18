import Foundation
import Combine
import FirebaseAuth

final class AccountViewModel: ObservableObject {

    @Published var userName: String = ""
    @Published var userEmail: String = ""

    let menuItems: [AccountMenuItem] = [
        .init(title: "Orders", icon: "bag", destination: .orders),
        .init(title: "My Details", icon: "person", destination: .myDetails),
        .init(title: "Delivery Address", icon: "location", destination: .deliveryAddress),
        .init(title: "Payment Methods", icon: "creditcard", destination: .paymentMethods),
        .init(title: "Promo Card", icon: "tag", destination: .promoCard),
        .init(title: "Notifications", icon: "bell", destination: .notifications),
        .init(title: "Help", icon: "questionmark.circle", destination: .help),
        .init(title: "About", icon: "info.circle", destination: .about)
    ]
}
