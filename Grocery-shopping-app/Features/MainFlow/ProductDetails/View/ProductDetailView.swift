import SwiftUI

struct ProductDetailView: View {

    let product: Product

    @State private var quantity: Int = 1

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Product Image
                    Image(product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 260)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))

                    // Name + favourite
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.name)
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text("1kg, Price")
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image(systemName: "heart")
                            .font(.title3)
                    }
                    .padding(.horizontal)

                    // Quantity + price
                    HStack(spacing: 20) {

                        HStack {
                            Button("-") {
                                if quantity > 1 { quantity -= 1 }
                            }

                            Text("\(quantity)")
                                .frame(width: 30)

                            Button("+") {
                                quantity += 1
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)

                        Spacer()

                        Text("$4.99")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)

                    Divider()

                    DisclosureGroup("Product Detail") {
                        Text("Apples Are Nutritious. Apples May Be Good For Weight Loss.Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    Divider()

                    // Nutrition
                    NavigationRow(title: "Nutritions", trailingText: "100gr")

                    Divider()

                    // Reviews
                    NavigationRow(title: "Review") {
                        HStack(spacing: 2) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            
            // Add to basket
            PrimaryButton(title: "Add to Basket"){
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(product: MockProducts.dummyProduct)
}
