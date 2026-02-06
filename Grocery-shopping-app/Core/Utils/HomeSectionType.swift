import Foundation

enum HomeSectionType: CaseIterable, Identifiable {

    case exclusiveOffer
    case bestSelling
    case groceries

    var id: Self { self }

    var title: String {
        switch self {
        case .exclusiveOffer:
            return "Exclusive Offer"
        case .bestSelling:
            return "Best Selling"
        case .groceries:
            return "Groceries"
        }
    }
}
