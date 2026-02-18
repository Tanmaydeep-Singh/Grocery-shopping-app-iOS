
import SwiftUI

struct ProductCard: View {

    let product: Product
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProductViewModel()
    
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
            Group {
                
                if viewModel.isInCart {
                    
                    HStack(spacing: 10) {
                        // MINUS
                        Button {
                            
                            if viewModel.quantity > 1 {
                                viewModel.quantity -= 1
                                viewModel.updateLocalQuantity()
                            } else {
                                Task {
                                    await viewModel.removeFromCart()
                                    withAnimation {
                                        viewModel.isInCart = false
                                        viewModel.quantity = 0
                                    }
                                }
                            }
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                        }
                        
                        
                        // QUANTITY
                        Text("\(viewModel.quantity)")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(minWidth: 16)
                        
                        
                        // PLUS
                        Button {
                            viewModel.quantity += 1
                            viewModel.updateLocalQuantity()
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 34)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
                }
                else
                {
                    PrimaryButton(icon: "plus", height: 44, width: 44, cornerRadius: 14){
                        
                        Task{
                            await viewModel.addToCart2( product: product)
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                viewModel.isInCart = true
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 12)
            .padding(.bottom, 12)
            .onAppear {
                Task {
                    await viewModel.onLoad(productId: product.id)
                }
            }
        }
    }
    
}

#Preview {
    ProductCard(product: MockProducts.dummyProduct)
}
