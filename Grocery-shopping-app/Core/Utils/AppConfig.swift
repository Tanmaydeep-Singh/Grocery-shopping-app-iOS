//
//  AppConfig.swift
//  Nectar
//
//  Created by tanmaydeep on 09/02/26.
//

import Foundation

enum AppConfig {
    static let apiBaseURL = getString("API_BASE_URL")

    
    private static func getString(_ key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Missing key in Info.plist")
        }
        
        return value.replacingOccurrences(of: " ", with: "")
    }
}
