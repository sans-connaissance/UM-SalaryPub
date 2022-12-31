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
    
    static func byName<T: NSManagedObject>(keyPath: String, name: String) -> [T]
    
    static func forDetailViews<T: NSManagedObject>(nameKeyPath: String, yearKeyPath: String, name: String, year: Int64) -> [T]
    
    static func campusesWithTitleOrDepartment<T: NSManagedObject>(nameKeyPath: String, yearKeyPath: String, name: String, year: Int64) -> [T]
    
    ///This is the primary search function for the app.
    static func search<T: NSManagedObject>(
        byYear: String,
        byType: String,
        bySearchText: String,
        byNamePredicate: String,
        sortAlphabetically: Bool,
        sortByMoneyDescending: Bool,
        sortByMoneyAscending: Bool,
        sortByPersonCountDescending: Bool,
        sortByPersonCountAscending: Bool,
        moneySortDescriptor: String,
        countSortDescriptor: String) -> [T]
}

///Default implementations of BaseModel funcs
extension BaseModel {
    
    /// Inspired by Mohammad Azam's implentation in Udemy's Core Data in iOS course.
    /// This simplifies viewContext calls in many parts of the code.
    ///  Eliminates need to call CoreDataManager.shared.
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    /// Array of years representing each year of data loaded into the database.
    /// Add year(s) here in order to import additional data.
    static var importYears: [Int] {
        return [2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013]
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
    
    static func byName<T>(keyPath: String, name: String) -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        let namePredicate = NSPredicate(format: "%K == %@", keyPath, name)
        
        fetchRequest.predicate = namePredicate
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func forDetailViews<T>(nameKeyPath: String, yearKeyPath: String, name: String, year: Int64) -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        let yearPredicate = NSPredicate(format: "\(yearKeyPath) <= %i", year)
        let namePredicate = NSPredicate(format: "\(nameKeyPath) = %@", name)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        
        fetchRequest.predicate = combinedPredicate
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func campusesWithTitleOrDepartment<T>(nameKeyPath: String, yearKeyPath: String, name: String, year: Int64) -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        let yearPredicate = NSPredicate(format: "\(yearKeyPath) = %i", year)
        let namePredicate = NSPredicate(format: "\(nameKeyPath) = %@", name)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        
        fetchRequest.predicate = combinedPredicate
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    /// Primary search function for the app
    /// enums are used to populate the various sortDescriptors and predicates
    static func search<T>(
        byYear: String,
        byType: String,
        bySearchText: String,
        byNamePredicate: String,
        sortAlphabetically: Bool,
        sortByMoneyDescending: Bool,
        sortByMoneyAscending: Bool,
        sortByPersonCountDescending: Bool,
        sortByPersonCountAscending: Bool,
        moneySortDescriptor: String,
        countSortDescriptor: String) -> [T] where T: NSManagedObject
    {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
            
        let sortByMoneyDescendingDescriptor = NSSortDescriptor(key: "\(moneySortDescriptor)", ascending: false)
        let sortByMoneyAscendingDescriptor = NSSortDescriptor(key: "\(moneySortDescriptor)", ascending: true)
        let sortAlphabeticallyDescriptor = NSSortDescriptor(key: "\(byNamePredicate)", ascending: true)
        let sortByPersonCountDescendingDescriptor = NSSortDescriptor(key: "\(countSortDescriptor)", ascending: false)
        let sortByPersonCountAscendingDescriptor = NSSortDescriptor(key: "\(countSortDescriptor)", ascending: true)
            
        let yearPredicate = NSPredicate(format: "\(byType) == %@", byYear)
        let namePredicate = NSPredicate(format: "\(byNamePredicate) CONTAINS[c] %@", bySearchText)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
            
        if sortByMoneyDescending { fetchRequest.sortDescriptors = [sortByMoneyDescendingDescriptor] }
        if sortByMoneyAscending { fetchRequest.sortDescriptors = [sortByMoneyAscendingDescriptor] }
        if sortAlphabetically { fetchRequest.sortDescriptors = [sortAlphabeticallyDescriptor] }
        if sortByPersonCountDescending { fetchRequest.sortDescriptors = [sortByPersonCountDescendingDescriptor] }
        if sortByPersonCountAscending { fetchRequest.sortDescriptors = [sortByPersonCountAscendingDescriptor] }
            
        fetchRequest.predicate = combinedPredicate
        fetchRequest.fetchBatchSize = 50
        fetchRequest.fetchLimit = 75
            
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}

//MARK: Explore refactoring enums
///Added enums in an attempt to make the ViewModel calls more readable, but I'm not sure if that clarity was accomplished.
enum NamePredicate: String, CaseIterable {
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
    case twentyTwo = 2022
    case twentyOne = 2021
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
        case .twentyTwo:
            return "2022"
        case .twentyOne:
            return "2021"
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

enum MoneySortDescriptor: String, CaseIterable {
    case Person
    case Title
    case Department
    case Campus
    
    var returnText: String {
        switch self {
        case .Person:
            return "apptAnnualFTR"
        case .Title:
            return "titleAverageAnnual"
        case .Department:
            return "departmentAverageAnnual"
        case .Campus:
            return "campusAverageAnnual"
        }
    }
}

enum CountSortDescriptor: String, CaseIterable {
    case Person
    case Title
    case Department
    case Campus
    
    var returnText: String {
        switch self {
        case .Person:
            return ""
        case .Title:
            return "titleCount"
        case .Department:
            return "departmentCount"
        case .Campus:
            return "campusCount"
        }
    }
}

enum YearByType: String, CaseIterable {
    case Person
    case Title
    case Department
    case Campus
    
    var returnText: String {
        switch self {
        case .Person:
            return "year"
        case .Title:
            return "titleYear"
        case .Department:
            return "departmentYear"
        case .Campus:
            return "campusYear"
        }
    }
}
