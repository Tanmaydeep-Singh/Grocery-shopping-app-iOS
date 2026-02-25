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
                    Text("🧑‍🍳 Preparing your order")
                        .font(.headline)
                    
                    ProgressView()
                    
                case .outForDelivery:
                    Text("🚚 Out for Delivery")
                        .font(.headline)
                    
                    if let endDate = context.state.estimatedEndDate {
                        
                        Text(
                            timerInterval: Date()...endDate,
                            countsDown: true
                        )
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        
                        ProgressView(
                            timerInterval: context.attributes.startDate...endDate,
                            countsDown: true
                        )
                        .progressViewStyle(.linear)
                    }
                    
                case .delivered:
                    Text("🎉 Order Delivered")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .activityBackgroundTint(.black)
            .activitySystemActionForegroundColor(.white)
            
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
        deliveryState: .outForDelivery
    )
}
