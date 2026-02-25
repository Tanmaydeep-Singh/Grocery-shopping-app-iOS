//
//  NectarDeliveryLiveActivityAttributes.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//


import ActivityKit
import Foundation
import Combine

struct NectarDeliveryLiveActivityAttributes : ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var endDate: Date
    }

    var startDate: Date
}
