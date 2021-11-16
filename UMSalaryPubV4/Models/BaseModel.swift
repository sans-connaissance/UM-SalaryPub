//
//  BaseModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/28/21.
//

import CoreData
import Foundation

protocol BaseModel where Self: NSManagedObject {
    
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    
    static func all<T: NSManagedObject>() -> [T]
    
    static func by<T: NSManagedObject>(keyPath: String, name: String) -> [T]

}


extension BaseModel {
    
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    static var importYears: [Int] {
        return [2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013]
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
    static func all<T>() -> [T] where T: NSManagedObject {
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func by<T>(keyPath: String, name: String) -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        
        let namePredicate = NSPredicate(format: "%K == %@", keyPath, name)
        
        fetchRequest.predicate = namePredicate
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

}

enum NameKeyPaths: String, CaseIterable {
    
    case Person
    case Title
    case Department
    case Campus
    
    var returnText: String {
        switch self {
        case .Person:
            return "fullName"
        case .Title:
            return "titleName"
        case .Department:
            return "departmentName"
        case .Campus:
            return "campusName"
        }
    }
}

enum FetchYear: Int, CaseIterable {
    
    case twenty = 2020
    case nineteen = 2019
    case eighteen = 2018
    case seventeen = 2017
    case sixteen = 2016
    case fifteen = 2015
    case fourteen = 2014
    case thirteen = 2013
    
    var displayText: String {
        
        switch self {
        case .twenty:
            return "2020"
        case .nineteen:
            return "2019"
        case .eighteen:
            return "2018"
        case .seventeen:
            return "2017"
        case .sixteen:
            return "2016"
        case .fifteen:
            return "2015"
        case .fourteen:
            return "2014"
        case .thirteen:
            return "2013"
        }
    }
}
