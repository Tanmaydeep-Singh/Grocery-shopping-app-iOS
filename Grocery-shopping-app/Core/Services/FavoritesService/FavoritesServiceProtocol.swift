//
//  FavoritesServiceProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 10/02/26.
//

import Foundation

protocol FavoritesServiceProtocol {
    func getFavorites(userId: String) async throws -> [FavouriteItem]
    func addToFavorites(userId: String, item: FavouriteItem) async throws
    func removeFromFavorites(userId: String, productId: Int) async throws
}
