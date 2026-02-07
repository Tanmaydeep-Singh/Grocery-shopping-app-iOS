import SwiftUI

struct ProductGridView: View {

    let title: String?
    let products: [Product]

    private let rows = [
        GridItem(.fixed(250))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            if let title {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
            }

            ScrollView(.horizontal, showsIndicators: false) {

                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(products) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            ProductCard(product: product)
                                .frame(width: 180)
                        }
                        .buttonStyle(.plain)
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
