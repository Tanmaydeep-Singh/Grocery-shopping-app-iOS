import SwiftUI

struct ProductDetailView: View {

    let product: Product

    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProductViewModel()
    @State private var quantity: Int = 1

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if let detail = viewModel.productDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Product Image
                        Image(detail.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 260)
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                        
                        // Name + favourite
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(detail.name)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
//                                Text("1kg, Price")
//                                    .foregroundColor(.gray)
                                
                                Text(detail.manufacturer)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            Button {
                                Task {
                                    let userId = authViewModel.user?.id ?? ""

                                    do {
                                        if viewModel.isFavorite {
                                            viewModel.removeFromFavorite(userId: userId)
                                        } else {
                                             viewModel.addToFavorites(userId: userId)
                                        }
                                    }
                                }

                            } label: {
                                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                    .font(.title3)
                                    .foregroundColor(viewModel.isFavorite ? .red : .primary)
                            }

                        }
                        .padding(.horizontal)
                        
                        // Quantity + price
                        HStack(spacing: 20) {
                            
                            HStack {
                                Button("-") {
                                    if quantity > 1 { quantity -= 1 }
                                }
                                .disabled(quantity == 1)

                                Text("\(quantity)")
                                    .frame(width: 30)

                                Button("+") {
                                    if quantity < detail.currentStock {
                                        quantity += 1
                                    }
                                }
                                .disabled(quantity == detail.currentStock)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(16)
                            
                            Spacer()
                            
                            Text("$\(detail.price, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        DisclosureGroup("Product Detail") {
                            Text("High quality product from \(detail.manufacturer)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
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
            else if let error = viewModel.errorMessage {
                       Text(error)
                           .foregroundColor(.red)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            let userId = authViewModel.user?.id ?? ""
            await viewModel.fetchProductDetail(productId: product.id, userId: userId)
        }
    }
}

#Preview {
    ProductDetailView(product: MockProducts.dummyProduct)
        .environmentObject(AuthViewModel())

}
