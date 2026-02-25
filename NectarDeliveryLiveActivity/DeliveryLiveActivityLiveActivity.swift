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
            var endDate: Date
        }

        // Static data (does not change)
        var startDate: Date
    }


    struct DeliveryLiveActivityLiveActivity: Widget {
        
        var body: some WidgetConfiguration {
            
            ActivityConfiguration(for: NectarDeliveryLiveActivityAttributes.self) { context in
                
                // LOCK SCREEN
                VStack(spacing: 12) {
                    
                    Text("⏳ 5 Minute Timer")
                        .font(.headline)
                    
                    Text(
                        timerInterval: Date()...context.state.endDate,
                        countsDown: true
                    )
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    
                    ProgressView(
                        timerInterval: context.attributes.startDate...context.state.endDate,
                        countsDown: true
                    )
                    .progressViewStyle(.linear)
                }
                .padding()
                .activityBackgroundTint(Color.black)
                .activitySystemActionForegroundColor(Color.white)
                
            } dynamicIsland: { context in
                
                DynamicIsland {
                    
                    // 🟢 EXPANDED
                    DynamicIslandExpandedRegion(.center) {
                        VStack(spacing: 6) {
                            
                            Text("Timer Running")
                                .font(.caption)
                            
                            Text(
                                timerInterval: Date()...context.state.endDate,
                                countsDown: true
                            )
                            .font(.title2)
                            .monospacedDigit()
                        }
                    }
                    
                } compactLeading: { // leading space for DI
                    
                    Text("⏳")
                    
                } compactTrailing: { // trailing space for DI
                    
                    Text(
                        timerInterval: Date()...context.state.endDate,
                        countsDown: true
                    )
                    .font(.caption2)
                    .monospacedDigit()
                    
                } minimal: {
                    
                    // 🔵 TINY FLOATING
                    Text("⏳")
                }
            }
        }
    }


    #Preview("Timer Preview", as: .content, using: NectarDeliveryLiveActivityAttributes(startDate: .now)) {
        DeliveryLiveActivityLiveActivity()
    } contentStates: {
        NectarDeliveryLiveActivityAttributes.ContentState(endDate: .now.addingTimeInterval(300))
    }
