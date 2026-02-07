
import SwiftUI

struct ProductCard: View {

    let product: Product

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(alignment: .leading, spacing: 10) {

                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)

                Text(product.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(2)

                Text("7pcs, Price")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                Text("$4.99")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
            }
            .padding()
            .frame(height: 240)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
            )
            
            PrimaryButton(icon: "plus", height: 44, width: 44, cornerRadius: 14){
                
            }
        }
    }
}

#Preview {
    ProductCard(product: MockProducts.dummyProduct)
}
