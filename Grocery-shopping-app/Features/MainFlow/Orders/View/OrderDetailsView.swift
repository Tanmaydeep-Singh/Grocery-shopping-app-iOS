import SwiftUI

struct OrderDetailsView: View {
    private let cartService = CartProductsService.shared
    @State private var showCartSheet = false;
    let order: Order
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Order #\(order.id.suffix(8).uppercased())")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text(order.createdOn.formatted(date: .long, time: .shortened))
                            .font(.system(size: 13))
                            .foregroundStyle(Color(.tertiaryLabel))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 14)
                    
                    Divider()
                        .padding(.horizontal, 16)
                    
                    HStack {
                        Text("Order Total")
                            .font(.system(size: 13))
                            .foregroundStyle(Color(.secondaryLabel))
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", order.totalPrice))")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
                .cardStyle()
                                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Items")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(.secondaryLabel))
                        .textCase(.uppercase)
                        .tracking(0.5)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                    
                    ForEach(Array(order.items.enumerated()), id: \.element.id) { index, item in
                        if index > 0 {
                            Divider()
                                .padding(.horizontal, 16)
                        }
                        
                        HStack(spacing: 12) {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .padding(6)
                                .background(Color(.systemGroupedBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(item.name)
                                    .font(.system(size: 14, weight: .medium))
                                
                                Text("Qty: \(item.quantity)")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color(.tertiaryLabel))
                            }
                            
                            Spacer()
                            
                            Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                }
                .cardStyle()
                                
                VStack(spacing: 10) {
                    NavigationLink {
                        RateOrdersView(order: order)
                    } label: {
                        OrderActionButton(title: "Rate", style: .standard)
                    }
                    Button {
                        cartService.reorder(order: order)
                        showCartSheet = true
                    } label: {
                        OrderActionButton(title: "Order Again", style: .destructive)
                    }
                    .buttonStyle(.plain)
                }
                .padding(16)
                .cardStyle()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .background(Color(.systemBackground))
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCartSheet, onDismiss: {cartService.clearCart()}) {
                    CartView()
                .presentationDetents([.fraction(0.8), .large])
                .presentationDragIndicator(.visible)
                }

    }
}

private extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.separator), lineWidth: 1)
            )
    }
}
