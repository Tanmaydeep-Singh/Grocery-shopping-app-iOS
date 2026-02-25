//
//  LiveActivityService.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import ActivityKit
import Foundation

final class LiveActivityService {
    
    static let shared = LiveActivityService()
    private init() {}
    

    // Start
    func start() async throws {
        
        let attributes = NectarDeliveryLiveActivityAttributes(
            startDate: Date()
        )
        
        let initialState = NectarDeliveryLiveActivityAttributes.ContentState(
            estimatedEndDate: nil,
            deliveryState: .preparing
        )
        
        let content = ActivityContent(
                    state: initialState,
                    staleDate: nil as Date?
                )
        
        _ = try Activity.request(
            attributes: attributes,
            content: content
        )
        
        // Start mock flow automatically
        await mockDeliveryProcess()
    }
    
        
    private func update(
        state: NectarDeliveryLiveActivityAttributes.DeliveryState,
        endDate: Date? = nil
    ) async {
        
        for activity in Activity<NectarDeliveryLiveActivityAttributes>.activities {
            
            let updatedState = NectarDeliveryLiveActivityAttributes.ContentState(
                estimatedEndDate: endDate,
                deliveryState: state
            )
            
            let content = ActivityContent(
                        state: updatedState,
                        staleDate: nil as Date?
                    )
            
            await activity.update(content)
        }
    }
    
    
        // end
    func end(
           finalState: NectarDeliveryLiveActivityAttributes.DeliveryState = .delivered
       ) async {
           
           for activity in Activity<NectarDeliveryLiveActivityAttributes>.activities {
               
               let finalState = NectarDeliveryLiveActivityAttributes.ContentState(
                   estimatedEndDate: nil,
                   deliveryState: finalState
               )
               
               let content = ActivityContent(
                   state: finalState,
                   staleDate: nil as Date?
               )
               
               await activity.end(
                   content,
                   dismissalPolicy: .after(Date().addingTimeInterval(5))
               )
           }
       }
       
       
       
       private func mockDeliveryProcess() async {
           
           // Preparing (5s)
           print("Preparing")
           try? await Task.sleep(nanoseconds: 5_000_000_000)
           
           let endDate = Date().addingTimeInterval(300)
           
           print("Out for delivery")
           // Out for delivery (10s countdown)
           await update(
               state: .outForDelivery,
               endDate: endDate
           )
           
           try? await Task.sleep(for: .seconds(300)) // 5 min
           
           print("Delivery")
           // Delivered
           await update(state: .delivered)
           
           try? await Task.sleep(nanoseconds: 3_000_000_000)
           
           await end()
       }
   }

