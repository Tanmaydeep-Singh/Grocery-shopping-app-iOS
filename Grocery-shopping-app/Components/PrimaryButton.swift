//
//  PrimaryButton.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//
//
import SwiftUI

struct PrimaryButton: View {
    let title: String?
    let icon: String?
    let textColor: Color
    let backgroundColor: Color
    let height: CGFloat
    let width: CGFloat?
    let cornerRadius: CGFloat
    let action: () -> Void

    init(
        title: String? = nil,
        icon: String? = nil,
        textColor: Color = .white,
        backgroundColor: Color = Color("Splash"),
        height: CGFloat = 67,
        width: CGFloat? = nil,
        cornerRadius: CGFloat = 19,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.width = width
        self.cornerRadius = cornerRadius
        self.action = action
    }

    var body: some View {
        ZStack {
            Button(action: action) {
                HStack(spacing: 10) {
                    if let icon {
                        Image(systemName: icon)
                    }
                    if let title = title {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(width: width, height: height)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    PrimaryButton(title: "Logout"){
        
    }
}
