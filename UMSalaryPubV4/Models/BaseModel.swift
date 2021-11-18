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
    
    static func search<T: NSManagedObject>(
                                           yearPredicate: String,
                                           yearByType: String,
                                           filterPredicate: String,
                                           descendingMoney: Bool,
                                           sortByMoneyAscending: Bool,
                                           moneySortDescriptor: String,
                                           alphabetSort: Bool,
                                           namePredicateOrSort: String,
                                           mostPeopleSort: Bool,
                                           leastPeopleSort: Bool,
                                           countSortDescriptor: String) -> [T]
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
    
    static func search<T>(
                          yearPredicate: String,
                          yearByType: String,
                          filterPredicate: String,
                          descendingMoney: Bool,
                          sortByMoneyAscending: Bool,
                          moneySortDescriptor: String,
                          alphabetSort: Bool,
                          namePredicateOrSort: String,
                          mostPeopleSort: Bool,
                          leastPeopleSort: Bool,
                          countSortDescriptor: String) -> [T] where T: NSManagedObject {
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        
        let descendingMoneyDescriptor = NSSortDescriptor(key: "\(moneySortDescriptor)", ascending: false)
        let sortByMoneyAscendingDescriptor = NSSortDescriptor(key: "\(moneySortDescriptor)", ascending: true)
        let alphabetSortDescriptor = NSSortDescriptor(key: "\(namePredicateOrSort)", ascending: true)
        let mostPeopleSortDescriptor = NSSortDescriptor(key: "\(countSortDescriptor)", ascending: false)
        let leastPeopleSortDescriptor = NSSortDescriptor(key: "\(countSortDescriptor)", ascending: true)
                              
        let yearPredicate = NSPredicate(format: "\(yearByType) == %@", yearPredicate)
        let namePredicate = NSPredicate(format: "\(namePredicateOrSort) CONTAINS[c] %@", filterPredicate)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        
        if descendingMoney { fetchRequest.sortDescriptors = [descendingMoneyDescriptor] }
        if sortByMoneyAscending { fetchRequest.sortDescriptors = [sortByMoneyAscendingDescriptor] }
        if alphabetSort { fetchRequest.sortDescriptors = [alphabetSortDescriptor] }
        if mostPeopleSort { fetchRequest.sortDescriptors = [mostPeopleSortDescriptor] }
        if leastPeopleSort { fetchRequest.sortDescriptors = [leastPeopleSortDescriptor] }
        
        fetchRequest.predicate = combinedPredicate
        fetchRequest.fetchBatchSize = 25
        fetchRequest.fetchLimit = 50
        
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
}

enum NamePredicateOrSort: String, CaseIterable {
    
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
