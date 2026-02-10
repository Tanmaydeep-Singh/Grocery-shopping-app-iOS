//
//  AppConfig.swift
//  Nectar
//
<<<<<<< HEAD
//  Created by rentamac on 2/9/26.
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
 
=======
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
>>>>>>> 7b910490c216742fce66e5786a5acdf9f9a12b40
