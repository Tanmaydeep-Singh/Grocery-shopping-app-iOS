//
//  CartEndpoints.swift
//  Nectar
//
//  Created by tanmaydeep on 08/02/26.
//

import Foundation

enum CartEndpoints: Endpoint {

    case createCart
    case getCart(cartId: String)

    case getCartItems(cartId: String)
    case addItemToCart(
        cartId: String,
        body: AddCartItemRequest
    )
    case updateCartItemQuantity(
        cartId: String,
        itemId: String,
        body: UpdateCartItemQuantityRequest
    )
    case replaceCartItem(
        cartId: String,
        itemId: String,
        body: ReplaceCartItemRequest
    )
    case removeCartItem(
        cartId: String,
        itemId: String
    )

    var path: String {
        switch self {
        case .createCart:
            return "carts"

        case .getCart(let cartId):
            return "carts/\(cartId)"

        case .getCartItems(let cartId),
             .addItemToCart(let cartId, _):
            return "carts/\(cartId)/items"

        case .updateCartItemQuantity(let cartId, let itemId, _),
             .replaceCartItem(let cartId, let itemId, _),
             .removeCartItem(let cartId, let itemId):
            return "carts/\(cartId)/items/\(itemId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .createCart:
            return .post
        case .getCart, .getCartItems:
            return .get
        case .addItemToCart:
            return .post
        case .updateCartItemQuantity:
            return .patch
        case .replaceCartItem:
            return .put
        case .removeCartItem:
            return .delete
        }
    }

    var body: Data? {
        switch self {
        case .addItemToCart(_, let request):
            return try? JSONEncoder().encode(request)
        case .updateCartItemQuantity(_, _, let request):
            return try? JSONEncoder().encode(request)
        case .replaceCartItem(_, _, let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
    }
}
