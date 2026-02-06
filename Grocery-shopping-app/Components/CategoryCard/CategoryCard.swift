//
//  CategoryCard.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct CategoryCard: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack(spacing: 12) {

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 111, height: 75)
                .padding(16)
                .opacity(1)

            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("CategoryText"))
        }
        .padding(12)
        .frame(height: 189)
        .background(Color("CategoryCardBackground"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("CategoryCardBorder"), lineWidth: 1)
        )
        .opacity(1)
    }
}
