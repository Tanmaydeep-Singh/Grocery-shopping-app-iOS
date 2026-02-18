//
//  AccountMenuItem.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import Foundation

struct AccountMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let destination: AccountDestination?
}


enum AccountDestination {
    case orders
    case myDetails
    case deliveryAddress
    case paymentMethods
    case promoCard
    case notifications
    case help
    case about
}
