//import SwiftUI
//
//struct OrderRowView: View {
//    
//    let order: Order
//    
//    private var formattedDate: String {
//        order.createdOn.formatted(date: .abbreviated, time: .omitted)
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//                        
//            HStack(alignment: .center) {
//                VStack(alignment: .leading, spacing: 3) {
//                    Text("Order #\(order.id.suffix(6).uppercased())")
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundStyle(.primary)
//                    
//                    Text(formattedDate)
//                        .font(.system(size: 12))
//                        .foregroundStyle(Color(.tertiaryLabel))
//                }
//                
//                Spacer()
//                
//                Text("$\(String(format: "%.2f", order.totalPrice))")
//                    .font(.system(size: 15, weight: .bold))
//                    .foregroundStyle(.primary)
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 16)
//            .padding(.bottom, 12)
//            
//            Divider()
//                .padding(.horizontal, 16)
//                        
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 8) {
//                    ForEach(order.items.prefix(4)) { item in
//                        Image(item.imageName)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 44, height: 44)
//                            .padding(6)
//                            .background(Color(.systemGroupedBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                    
//                    if order.items.count > 4 {
//                        Text("+\(order.items.count - 4)")
//                            .font(.system(size: 12, weight: .semibold))
//                            .foregroundStyle(Color(.secondaryLabel))
//                            .frame(width: 44, height: 44)
//                            .background(Color(.systemGroupedBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 12)
//            }
//            
//            Divider()
//                .padding(.horizontal, 16)
//                        
//            HStack(spacing: 10) {
//                Button("Rate") { }
//                    .font(.system(size: 13, weight: .medium))
//                    .foregroundStyle(.primary)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 9)
//                    .background(Color(.systemGroupedBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 9))
//                
//                Button("Order Again") { }
//                    .font(.system(size: 13, weight: .medium))
//                    .foregroundStyle(Color.red)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 9)
//                    .background(Color.red.opacity(0.06))
//                    .clipShape(RoundedRectangle(cornerRadius: 9))
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 12)
//        }
//        .background(Color(.systemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 16))
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color(.separator).opacity(0.5), lineWidth: 1)
//        )
//        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
//    }
//}

import SwiftUI

struct OrderRowView: View {
    
    let order: Order
    
    private var formattedDate: String {
        order.createdOn.formatted(date: .abbreviated, time: .omitted)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Order #\(order.id.suffix(6).uppercased())")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.primary)
                    
                    Text(formattedDate)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
                
                Spacer()
                
                Text("$\(String(format: "%.2f", order.totalPrice))")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            Divider()
                .padding(.horizontal, 16)
            
            // MARK: - Item Images
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(order.items.prefix(4)) { item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .padding(6)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    if order.items.count > 4 {
                        Text("+\(order.items.count - 4)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color(.secondaryLabel))
                            .frame(width: 44, height: 44)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            
            Divider()
                .padding(.horizontal, 16)
            
            // MARK: - Actions
            
            HStack(spacing: 10) {
                OrderActionButton(title: "Rate", style: .standard) { }
                OrderActionButton(title: "Order Again", style: .destructive) { }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator).opacity(0.5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
    }
}
