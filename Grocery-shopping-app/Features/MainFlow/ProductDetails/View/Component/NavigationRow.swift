import SwiftUI

struct NavigationRow<Content: View>: View {

    let title: String
    let content: Content?

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    init(title: String, trailingText: String) where Content == Text {
        self.title = title
        self.content = Text(trailingText)
            .foregroundColor(.gray)
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)

            Spacer()

            content

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationRow(title: "Testing", trailingText: "This is for testing purpose")
}
