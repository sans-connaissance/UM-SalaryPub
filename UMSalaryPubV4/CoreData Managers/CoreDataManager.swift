//
//  CoreDataManager.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    let containerPath = Bundle.main.path(forResource: "UMSalaryPub", ofType: "sqlite")
    
    static let shared = CoreDataManager()
    
    private init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "UMSalaryPub")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: containerPath ?? "/dev/null")
        }
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                print("Could not fetch. \(nserror)")
            }
        }
    }
   
}
