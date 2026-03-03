//
//  DeliveryStateStore.swift
//  Nectar
//
//  Created by tanmaydeep on 26/02/26.
//

import Foundation
import Combine

@MainActor
final class DeliveryStateStore: ObservableObject {
    
    static let shared = DeliveryStateStore()
    
    @Published var state: NectarDeliveryLiveActivityAttributes.DeliveryState?
    @Published var startDate: Date?
    @Published var estimatedEndDate: Date?
    
    private init() {}
    
    func start(preparationEndDate: Date) {
        state = .preparing
        startDate = Date()
        estimatedEndDate = preparationEndDate
    }
    
    func update(state: NectarDeliveryLiveActivityAttributes.DeliveryState,
                endDate: Date?) {
        self.state = state
        self.estimatedEndDate = endDate
    }
    
    func end() {
        state = nil
        startDate = nil
        estimatedEndDate = nil
    }
}
