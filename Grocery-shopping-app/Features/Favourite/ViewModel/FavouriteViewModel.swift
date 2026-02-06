//
//  FavouriteViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI
internal import Combine

@MainActor
final class FavouriteViewModel: ObservableObject {

    @Published var favouriteItems: [CartItem] = []

    init() {
        loadDummyFavourites()
    }

    private func loadDummyFavourites() {
        favouriteItems = [
            CartItem(
                id: "1",
                productName: "Sprite Can",
                productImageURL: "",
                unitDescription: "325ml",
                price: 1.50,
                quantity: 1
            ),
            CartItem(
                id: "2",
                productName: "Diet Coke",
                productImageURL: "",
                unitDescription: "355ml",
                price: 1.99,
                quantity: 1
            ),
            CartItem(
                id: "3",
                productName: "Apple & Grape Juice",
                productImageURL: "",
                unitDescription: "2L",
                price: 15.50,
                quantity: 1
            ),
            CartItem(
                id: "4",
                productName: "Coca Cola Can",
                productImageURL: "",
                unitDescription: "325ml",
                price: 4.99,
                quantity: 1
            ),
            CartItem(
                id: "5",
                productName: "Pepsi Can",
                productImageURL: "",
                unitDescription: "330ml",
                price: 4.99,
                quantity: 1
            )
        ]
    }
}
