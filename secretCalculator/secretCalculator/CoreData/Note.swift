//
//  Note.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 8/9/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SecretNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading from CoreData: \(error)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    
}
