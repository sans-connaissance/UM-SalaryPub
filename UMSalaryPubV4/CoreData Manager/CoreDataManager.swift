//
//  CoreDataManager.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import CoreData
import Foundation

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    let containerPath = Bundle.main.path(forResource: "UMSalaryPub", ofType: "sqlite")
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init(inMemory: Bool = true) {
        persistentContainer = NSPersistentContainer(name: "UMSalaryPub")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!
                .url = URL(fileURLWithPath: containerPath ?? "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Could not fetch. \(nserror)")
            }
        }
    }
}
