import SwiftUI

struct OrderActionButton: View {
    
    let title: String
    let style: Style
    let action: () -> Void
    
    enum Style {
        case standard
        case destructive
    }
    
    var body: some View {
        Button(title, action: action)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(style == .destructive ? .red : .primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 11)
            .background(style == .destructive ? Color.red.opacity(0.06) : Color(.systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 11))
    }
}
