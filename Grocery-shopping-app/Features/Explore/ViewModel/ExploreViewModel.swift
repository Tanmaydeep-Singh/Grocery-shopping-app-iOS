//
//  ExploreViewModel.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct ExploreViewModel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Category: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

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

#Preview {
    ExploreViewModel()
}
