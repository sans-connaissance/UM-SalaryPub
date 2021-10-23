//
//  Person+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Foundation
import CoreData
import SwiftUI

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var amtSalaryFromGeneralFund: Double
    @NSManaged public var apptAnnualFTR: Double
    @NSManaged public var apptFraction: Double
    @NSManaged public var apptFTRBasis: String?
    @NSManaged public var fullName: String?
    @NSManaged public var year: Int64
    @NSManaged public var campus: Campus?
    @NSManaged public var department: Department?
    @NSManaged public var title: Title?
    
    static func twentyTwentyPersons() -> FetchRequest<Person> {
        let yearPredicate = NSPredicate(format: "year == 2020")
        // let yearPredicate = NSPredicate(format: "firstName == 'Dave'")
        //let lastNameSortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        return FetchRequest(entity: Person.entity(), sortDescriptors: [], predicate: yearPredicate)
        
    }

}

extension Person : Identifiable {

}
