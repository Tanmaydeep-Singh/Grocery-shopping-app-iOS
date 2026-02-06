//
//  FilterCategoryRow.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//
import SwiftUI

struct FilterCategoryRow: View {
    let title: String
    @Binding var isSelected: Bool

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .green : .gray)
                    .font(.system(size: 20))

                Text(title)
                    .font(.body)
                    .foregroundColor(isSelected ? .green : .primary)

                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

