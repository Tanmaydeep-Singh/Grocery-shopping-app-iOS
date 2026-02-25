//import SwiftUI
//
//struct SearchBarView: View {
//    @Binding var text: String
//
//    var body: some View {
//        ZStack{
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("home_search", text: $text)
//                if !text.isEmpty {
//                    Button {
//                        text = ""
//                    } label: {
//                        Spacer()
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.gray)
//                    }
//                    .transition(.opacity)
//                }
//            }
//            .padding()
//            .background(Color(.systemGray6))
//            .cornerRadius(12)
//            .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
//        }
//        .padding(.horizontal)
//    }
//}
//
//#Preview {
//    SearchBarView(text: .constant(""))
//}
