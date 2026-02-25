//
//  ComingSoonView.swift
//  Nectar
//
//  Created by rentamac on 2/25/26.
//


import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Central Icon
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "clock.badge.checkmark.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.green)
            }
            
            VStack(spacing: 10) {
                Text("Coming Soon")
                    .font(.system(size: 26, weight: .bold))
                
                Text("We are working on something exciting.\nThis feature will be live soon!")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            
            Text("Nectar")
                .font(.system(size: 12, weight: .black))
                .tracking(2)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
