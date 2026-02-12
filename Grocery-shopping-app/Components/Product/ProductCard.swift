
import SwiftUI

struct ProductCard: View {

    let product: Product
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProductCardViewModel()
    @State private var showAddedAlert = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(alignment: .leading, spacing: 10) {

                Image(product.imageName ?? "")
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
                Task{
                    let cartId = authViewModel.user?.cartId ?? ""
                    await viewModel.addToCart(cartId:cartId, productId: product.id)
                    showAddedAlert = true
                }
            }
        }.alert("Success", isPresented: $showAddedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Item added to cart")
        }
    }
    
}

#Preview {
    ProductCard(product: MockProducts.dummyProduct)
}
