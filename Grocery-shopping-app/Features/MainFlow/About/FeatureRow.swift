//
//  FeatureRow.swift
//  Nectar
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 24)

            Text(text)
                .font(.body)

            Spacer()
        }
    }
}
