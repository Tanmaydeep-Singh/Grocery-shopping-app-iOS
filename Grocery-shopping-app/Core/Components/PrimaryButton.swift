//
//  PrimaryButton.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//
//
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let textColor: Color
    let backgroundColor: Color
    let height: CGFloat
    let cornerRadius: CGFloat
    let action: () -> Void

    init(
        title: String,
        icon: String? = nil,
        textColor: Color = .white,
        backgroundColor: Color = Color("Splash"),
        height: CGFloat = 67,
        cornerRadius: CGFloat = 19,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
        .buttonStyle(.plain)
    }
}

