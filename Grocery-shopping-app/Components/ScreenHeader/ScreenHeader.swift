import SwiftUI

struct ScreenHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(Color("PrimaryText"))
            .lineSpacing(-2)
            .frame(height: 18)
            .padding(16)
            .background(Color.clear)
            .cornerRadius(16)
            .opacity(1)
    }
}
