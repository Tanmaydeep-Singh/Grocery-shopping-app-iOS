//
//  FavouriteViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import Foundation
import Combine

@MainActor
final class FavouriteViewModel: ObservableObject {

    @Published var favouriteItems: [FavouriteItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let favoritesService: FavoritesServiceProtocol

    init(
    ) {
        self.favoritesService = FavoritesService()
    }

    func loadFavorites(userId: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            favouriteItems = try await favoritesService.getFavorites(userId: userId)

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
