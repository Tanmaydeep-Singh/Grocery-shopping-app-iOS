import SwiftUI

struct OrderRowView: View {
    
    let order: Order
    
    private var formattedDate: String {
        order.createdOn.formatted(date: .abbreviated, time: .omitted)
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
            // MARK: - Header
            
            HStack {
                Text("Order #\(order.id.suffix(6))")
                    .font(.system(size: 15, weight: .semibold))
                
                Spacer()
                
                Text("$\(String(format: "%.2f", order.totalPrice))")
                    .font(.system(size: 16, weight: .semibold))
            }
            
            Text(formattedDate)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
            
            Divider()
            
            
            // MARK: - Horizontal Item Images (Zepto Style)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    
                    ForEach(order.items.prefix(4)) { item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                            .padding(6)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    if order.items.count > 4 {
                        Text("+\(order.items.count - 4)")
                            .font(.system(size: 12, weight: .semibold))
                            .frame(width: 42, height: 42)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            
            Divider()
            
            
            // MARK: - Actions
            
            HStack(spacing: 10) {
                
                Button("Rate") { }
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("Order Again") { }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
