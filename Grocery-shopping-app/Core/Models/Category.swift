import Foundation
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let value: String
    
    var backgroundColor: Color {
        switch value {
        case "fresh-produce":
            return Color(hex: "#EAF3EC")
        case "meat-seafood":
            return Color(hex: "#F8E6E6")
        case "dairy":
            return Color(hex: "#F8F3E6")
        case "cooking-oil":
            return Color(hex: "#FCEFE6")
        case "beverages":
            return Color(hex: "#E6F0F8")
        case "bread-bakery":
            return Color(hex: "#F3ECF8")
        default:
            return Color.gray.opacity(0.1)
        }
    }
    
    var borderColor: Color {
        switch value {
        case "fresh-produce":
            return Color(hex: "#53B175")
        case "meat-seafood":
            return Color(hex: "#F7A593")
        case "dairy":
            return Color(hex: "#FDE598")
        case "cooking-oil":
            return Color(hex: "#F8A44C")
        case "beverages":
            return Color(hex: "#B7DFF5")
        case "bread-bakery":
            return Color(hex: "#D3B0E0")
        default:
            return Color.gray
        }
    }
}
