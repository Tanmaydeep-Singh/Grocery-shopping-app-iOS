//
//  PersistenceManager.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import Foundation
import CoreData

final class PersistenceManager {

    static let shared = PersistenceManager()
    
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "")
        
        // Load persistent stores (creates or opens the SQLite database)
        container.loadPersistentStores { _, error in
                          if let error = error as NSError? {
                              fatalError("Core Data load error: \(error)")
                          }
                      }
        
        // setting merge policy to avoid conflicts
        container.viewContext.mergePolicy =
                           NSMergeByPropertyObjectTrumpMergePolicy
               
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    
    
    
}
