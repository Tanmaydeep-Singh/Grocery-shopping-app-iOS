//
//  LiveActivityService.swift .swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//
import ActivityKit
import Foundation

final class LiveActivityService {
    
    static let shared = LiveActivityService()
    private init() {}
    
    private var timerActivity: Activity<NectarDeliveryLiveActivityAttributes>?
    
    func startFiveMinuteTimer() async throws {
        
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(300)
        
        let attributes = NectarDeliveryLiveActivityAttributes(startDate: startDate)
        let state = NectarDeliveryLiveActivityAttributes.ContentState(endDate: endDate)
        
        let content = ActivityContent(
            state: state,
            staleDate: endDate
        )
        
        timerActivity = try Activity.request(
            attributes: attributes,
            content: content,
            pushType: nil
        )
    }
    
    func endTimer() async {
        guard let timerActivity else { return }
        
        let finalState = NectarDeliveryLiveActivityAttributes.ContentState(
            endDate: Date()
        )
        
        let finalContent = ActivityContent(
            state: finalState,
            staleDate: nil
        )
        
        await timerActivity.end(
            finalContent,
            dismissalPolicy: .immediate
        )
        
        self.timerActivity = nil
    }
}
