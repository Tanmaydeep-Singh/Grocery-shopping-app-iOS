import Foundation
import Combine
import SwiftUI

final class ExploreViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var searchText: String = ""

    init() {
        loadCategories()
    }

    private func loadCategories() {
        categories = ProductCategory.allCases.map { $0.toCategory() }
    }
}
