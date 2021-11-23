//
//  Persistence.swift
//  UiKitApp
//
//  Created by Егор Пехота on 23.11.2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let containter: NSPersistentContainer
    
    init() {
        containter = NSPersistentContainer(name: "CBTModel")
        
        containter.loadPersistentStores(completionHandler: {
            description, error in
            if let error = error {
                fatalError("Core Data failed to load with error: \(error)")
            }
        })
    }
}
