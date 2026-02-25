//
//  NectarDeliveryLiveActivityLiveActivity.swift
//  NectarDeliveryLiveActivity
//
//  Created by tanmaydeep on 25/02/26.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct NectarDeliveryLiveActivityAttributes: ActivityAttributes {
    
    // Dynamic data. ( Only this gets updated)
    public struct ContentState: Codable, Hashable {
        var estimatedEndDate: Date?
        var deliveryState: DeliveryState
    }
    
    // Static data (does not change)
    var startDate: Date
    
    enum DeliveryState: String, Codable, Hashable {
        case preparing
        case outForDelivery
        case delivered
    }
}


struct DeliveryLiveActivityLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        
        ActivityConfiguration(for: NectarDeliveryLiveActivityAttributes.self) { context in
            
            VStack(spacing: 12) {
                
                switch context.state.deliveryState {
                    
                case .preparing:
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Preparing your order")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("We are preparing your order")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ProgressView()
                                .progressViewStyle(.linear)
                                .tint(Color("Splash"))
                                .frame(height: 4)
                                .padding(.top, 6)
                        }
                        
                        Spacer()
                        
                        Image("Basket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color("Splash").opacity(0.2))
                            )
                    }
                    
                    
                case .outForDelivery:
                    HStack(alignment: .center, spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("🚚 Out for Delivery")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("Your order is out for delivery")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            if let endDate = context.state.estimatedEndDate {
                                
                                ProgressView(
                                    timerInterval: context.attributes.startDate...endDate,
                                    countsDown: true
                                )
                                .tint(Color("Splash"))
                                .progressViewStyle(.linear)
                            }
                        }
                        
                        Spacer()
                        
                        Image("Basket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color("Splash").opacity(0.2))
                            )
                    }
                    
                    
                    
                    
                case .delivered:
                    HStack(alignment: .center, spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("🎉 Order Delivered")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("Your order has been delivered")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                                
                             
                
                        }
                        
                        Spacer()
                        
                        Image("Basket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color("Splash").opacity(0.2))
                            )
                    }
                    
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color("Splash").opacity(0.2))
            )
            .activityBackgroundTint(.white)
            .activitySystemActionForegroundColor(.black)
            
        } dynamicIsland: { context in
            
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.center) {
                    
                    switch context.state.deliveryState {
                        
                    case .preparing:
                        Text("Preparing 🧑‍🍳")
                        
                    case .outForDelivery:
                        VStack {
                            Text("On the way 🚚")
                            
                            if let endDate = context.state.estimatedEndDate {
                                Text(
                                    timerInterval: Date()...endDate,
                                    countsDown: true
                                )
                                .monospacedDigit()
                            }
                        }
                        
                    case .delivered:
                        Text("Delivered 🎉")
                            .foregroundColor(.green)
                    }
                }
                
            } compactLeading: {
                Image(systemName: "bag.fill")
                
            } compactTrailing: {
                
                switch context.state.deliveryState {
                    
                case .preparing:
                    Image(systemName: "clock")
                    
                case .outForDelivery:
                        Image(systemName: "timer")
                    
                case .delivered:
                    Image(systemName: "checkmark.circle.fill")
                }
                
            } minimal: {
                Image(systemName: "bag.fill")
            }
        }
    }
}

#Preview("Out For Delivery", as: .content,
         using: NectarDeliveryLiveActivityAttributes(startDate: .now)) {
    
    DeliveryLiveActivityLiveActivity()
    
} contentStates: {
    NectarDeliveryLiveActivityAttributes.ContentState(
        estimatedEndDate: .now.addingTimeInterval(300),
        deliveryState: .delivered
    )
}
