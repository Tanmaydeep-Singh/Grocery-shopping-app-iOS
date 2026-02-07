//
//  CommonButton.swift
//  Nectar
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

struct CommonButton : View {
    let ButtonText: String
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(ButtonText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color("Splash"))
                .cornerRadius(19)
        }
        .padding(16)
    }
}
