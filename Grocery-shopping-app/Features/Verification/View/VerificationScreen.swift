//
//  VerificationScreen.swift
//  Nectar
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct VerificationScreen: View {

    @State private var otpCode: String = ""
    @FocusState private var isKeyboardFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
           
           
            Text("Enter your 4-digit code")
                .font(.system(size: 26, weight: .semibold))
                .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Code")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("- - - -", text: $otpCode)
                    .font(.system(size: 18, weight: .bold))
                    .keyboardType(.numberPad)
                    .focused($isKeyboardFocused)
                    .onChange(of: otpCode) { oldValue, newValue in
                        if newValue.count > 4 {
                            otpCode = String(newValue.prefix(4))
                        }
                    }
                
                Divider()
            }
            
            Spacer()
            
            HStack {
                Text("Resend Code")
                    .font(.system(size: 18))
                    .foregroundColor(Color("Splash"))
                
                Spacer()
                
                Button {
                    // Verification Logic
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color("Splash"))
                        .clipShape(Circle())
                        .shadow(color: Color("Splash").opacity(0.3), radius: 10, x: 0, y: 5)
                }
            }
        }
        .padding(25)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isKeyboardFocused = true
        }
    }
}

#Preview {
    VerificationScreen()
}
