
//
//  NectarDeliveryLiveActivityAttributes.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import ActivityKit
import Foundation

struct NectarDeliveryLiveActivityAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var estimatedEndDate: Date?
        var deliveryState: DeliveryState
    }
    
    var startDate: Date
    
    enum DeliveryState: String, Codable, Hashable {
        case preparing
        case outForDelivery
        case delivered
    }
}
