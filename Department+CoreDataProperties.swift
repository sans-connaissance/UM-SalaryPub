//
//  Department+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Foundation
import CoreData
import SwiftUI


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var departmentAverageAnnual: Double
    @NSManaged public var departmentCount: Double
    @NSManaged public var departmentMaxAnnual: Double
    @NSManaged public var departmentMedianAnnual: Double
    @NSManaged public var departmentMinAnnual: Double
    @NSManaged public var departmentName: String?
    @NSManaged public var departmentYear: Int64
    @NSManaged public var personsInDepartment: Array<Person>
    
    static func twentyTwentyDepartments() -> FetchRequest<Department> {
        
        let yearPredicate = NSPredicate(format: "ANY personsInDepartment.year = %@", "2020")
        
        return FetchRequest(entity: Department.entity(), sortDescriptors: [], predicate: yearPredicate)
        
    }

}

// MARK: Generated accessors for personsInDepartment
extension Department {

    @objc(insertObject:inPersonsInDepartmentAtIndex:)
    @NSManaged public func insertIntoPersonsInDepartment(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsInDepartmentAtIndex:)
    @NSManaged public func removeFromPersonsInDepartment(at idx: Int)

    @objc(insertPersonsInDepartment:atIndexes:)
    @NSManaged public func insertIntoPersonsInDepartment(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsInDepartmentAtIndexes:)
    @NSManaged public func removeFromPersonsInDepartment(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsInDepartmentAtIndex:withObject:)
    @NSManaged public func replacePersonsInDepartment(at idx: Int, with value: Person)

    @objc(replacePersonsInDepartmentAtIndexes:withPersonsInDepartment:)
    @NSManaged public func replacePersonsInDepartment(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsInDepartmentObject:)
    @NSManaged public func addToPersonsInDepartment(_ value: Person)

    @objc(removePersonsInDepartmentObject:)
    @NSManaged public func removeFromPersonsInDepartment(_ value: Person)

    @objc(addPersonsInDepartment:)
    @NSManaged public func addToPersonsInDepartment(_ values: NSOrderedSet)

    @objc(removePersonsInDepartment:)
    @NSManaged public func removeFromPersonsInDepartment(_ values: NSOrderedSet)

}

extension Department : Identifiable {

}
