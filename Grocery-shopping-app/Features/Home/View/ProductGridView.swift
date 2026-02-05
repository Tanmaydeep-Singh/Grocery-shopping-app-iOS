import SwiftUI

struct ProductGridView: View {

    let title: String
    let products: [Product]

    private let rows = [
        GridItem(.fixed(250))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {

                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(products) { product in
                        ProductCard(product: product)
                            .frame(width: 180)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    ProductGridView(title: "Featured Products", products: MockProducts.products)
}
