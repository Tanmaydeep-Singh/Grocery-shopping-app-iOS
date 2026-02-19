//
//  DetailTextField.swift
//  Nectar
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

struct DetailTextField: View {

    let title: String
    @Binding var text: String
    var isEditable: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            TextField("", text: $text)
                .disabled(!isEditable)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
