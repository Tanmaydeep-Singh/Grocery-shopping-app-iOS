import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        ZStack{
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("home_search", text: $text)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
