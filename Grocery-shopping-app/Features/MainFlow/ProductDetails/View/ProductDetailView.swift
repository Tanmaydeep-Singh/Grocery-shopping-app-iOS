import SwiftUI

struct ProductDetailView: View {

    let productId: Int

    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProductViewModel()
    @State private var showAddedAlert = false
    @Namespace private var buttonTransition
    @EnvironmentObject var router: AppRouter

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
                                    let userId = authViewModel.user?.id ?? "iuREta11D5NW1sUzofRW7yLGEeA2"
                                    
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
                                
                                if viewModel.isInCart {
                                    
                                    HStack {
                                        
                                        Button(action: {
                                            if viewModel.quantity > 1 {
                                                viewModel.quantity -= 1
                                                viewModel.updateLocalQuantity()
                                            }
                                            else if viewModel.quantity == 1 {
                                                Task{
                                                    await viewModel.removeFromCart()
                                                }
                                                }
                                        }) {
                                            Image(systemName: "minus")
                                                .frame(width: 40, height: 40)
                                        }
                                        
                                        Text("\(viewModel.quantity)")
                                            .frame(width: 30)
                                        
                                        Button(action: {
                                            if viewModel.quantity < detail.currentStock {
                                                viewModel.quantity += 1
                                                viewModel.updateLocalQuantity()
                                            }
                                        }) {
                                            Image(systemName: "plus")
                                                .frame(width: 40, height: 40)
                                        }
                                        .disabled(viewModel.quantity == detail.currentStock)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(16)
                                }
                                
                                Spacer()
                                
                                Text("$\(detail.price, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal)
                        }
                        
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
                
                PrimaryButton(
                    title: viewModel.isInCart ? "Go to Cart" : "Add to Cart"
                ) {
                    Task {
                        if viewModel.isInCart {
                            router.selectedTab = .cart

                        } else {
                            await viewModel.addToCart()
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                viewModel.isInCart = true
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            let userId = authViewModel.user?.id ?? "iuREta11D5NW1sUzofRW7yLGEeA2"
            await viewModel.fetchProductDetail(productId: productId, userId: userId)
        }
    }
}

#Preview {
    ProductDetailView(productId: MockProducts.dummyProduct.id)
        .environmentObject(AuthViewModel())
}
