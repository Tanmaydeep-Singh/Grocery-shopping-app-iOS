import SwiftUI

struct OrderDetailsView: View {
    
    let order: Order
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Order #\(order.id.suffix(8).uppercased())")
                        .font(.system(size: 17, weight: .semibold))
                    
                    Text(order.createdOn.formatted(date: .long, time: .shortened))
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", order.totalPrice))")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                
                
                VStack(alignment: .leading, spacing: 14) {
                    
                    Text("Items")
                        .font(.system(size: 16, weight: .semibold))
                    
                    ForEach(order.items) { item in
                        
                        HStack(spacing: 12) {
                            
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 46, height: 46)
                                .padding(6)
                                .background(Color(.tertiarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Text("Qty: \(item.quantity)")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                
                
                VStack(spacing: 10) {
                    
                    Button("Rate Order") {
                    }
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                    Button("Order Again") {
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .background(Color(.systemBackground))
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

