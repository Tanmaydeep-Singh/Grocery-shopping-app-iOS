//
//  GridLayout.swift
//  Nectar
//
//  Created by rentamac on 2/6/26.
//
import SwiftUI

enum GridLayout {
    case twoColumn
    case threeColumn
    case adaptive(minWidth: CGFloat)

    var columns: [GridItem] {
        switch self {
        case .twoColumn:
            return [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ]

        case .threeColumn:
            return [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ]

        case .adaptive(let minWidth):
            return [
                GridItem(.adaptive(minimum: minWidth), spacing: 16)
            ]
        }
    }
}
