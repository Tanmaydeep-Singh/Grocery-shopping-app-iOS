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
    let backgroundColor: Color
    let borderColor: Color

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width

            VStack(spacing: width * 0.06) {

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: width * 0.6)   // responsive image height
                    .padding(width * 0.08)

                Text(title)
                    .font(.system(size: width * 0.09,
                                  weight: .semibold,
                                  design: .rounded))
                    .foregroundColor(Color("CategoryText"))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: width * 0.12))
            .overlay(
                RoundedRectangle(cornerRadius: width * 0.12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .aspectRatio(0.85, contentMode: .fit) // keeps card proportions consistent
    }
}

