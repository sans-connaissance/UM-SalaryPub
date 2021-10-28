//
//  CoreDataManager.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
//MARK: I think I'll have to write a bunch of extensions for all the search functions and stuff by category (people, title, etc.)
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    let containerPath = Bundle.main.path(forResource: "UMSalaryPub", ofType: "sqlite")
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init(inMemory: Bool = false) {
        
        persistentContainer = NSPersistentContainer(name: "UMSalaryPub")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: containerPath ?? "/dev/null")
        }
        
        persistentContainer.loadPersistentStores(completionHandler: { (NSReadOnlyPersistentStoreOption, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //this is redundant -- I only need to do this in the Person+CoreDataClass model
    // All of the model type calls can be moved into their respective extensions
    func getAllPersons() -> [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest(year: "2020")
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func getAllTitles() -> [Title] {
        let fetchRequest: NSFetchRequest<Title> = Title.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    func getAllDepartments() -> [Department] {
        let fetchRequest: NSFetchRequest<Department> = Department.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func getAllCampuses() -> [Campus] {
        let fetchRequest: NSFetchRequest<Campus> = Campus.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
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
