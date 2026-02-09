import SwiftUI

struct CategoryChipView: View {

    let category: Category

    var body: some View {
        HStack(spacing: 12) {

            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())

            Text(category.title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(width: 180)
        .background(Color(red: 0.99, green: 0.95, blue: 0.90))
        .cornerRadius(16)
        .onTapGesture {
            Task {
                await viewModel.fetchProducts(category: .coffee)
            }
        }

    }
}
