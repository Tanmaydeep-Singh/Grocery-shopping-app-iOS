//
//  FilterCategoryRow.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//
import SwiftUI

struct FilterCategoryRow: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.body)

            Spacer()

            Image(systemName: "checkmark.circle")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
