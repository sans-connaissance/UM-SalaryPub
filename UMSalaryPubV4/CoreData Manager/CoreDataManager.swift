//
//  CoreDataManager.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import CoreData
import Foundation

class CoreDataManager {
    /// This version of the CoreDataManger class was inspired by Mohammad Azam's implentation in Udemy's Core Data in iOS course.
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    let containerPath = Bundle.main.path(forResource: "UMSalaryPub", ofType: "sqlite")
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    /// Set inMemory: Bool to false to load data from JSON files
    /// See working with Default Data in Core Data Apps for more information: https://developer.apple.com/library/archive/technotes/tn2350/_index.html
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
