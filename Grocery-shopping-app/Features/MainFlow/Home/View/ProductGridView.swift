import SwiftUI

struct ProductGridView: View {

    let title: String?
    let products: [Product]
    let isLoading: Bool

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

            if isLoading{
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(products) { product in
                            NavigationLink {
                                ProductDetailView(productId: product.id)
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    ProductGridView(title: "Featured Products", products: MockProducts.products, isLoading: false)
}
