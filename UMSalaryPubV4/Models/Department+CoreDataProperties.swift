//
//  Department+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Charts
import CoreData
import Foundation

extension Department: BaseModel {
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
    @NSManaged public var personsInDepartment: [Person]
}

// MARK: Generated accessors for personsInDepartment

public extension Department {
    @objc(insertObject:inPersonsInDepartmentAtIndex:)
    @NSManaged func insertIntoPersonsInDepartment(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsInDepartmentAtIndex:)
    @NSManaged func removeFromPersonsInDepartment(at idx: Int)

    @objc(insertPersonsInDepartment:atIndexes:)
    @NSManaged func insertIntoPersonsInDepartment(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsInDepartmentAtIndexes:)
    @NSManaged func removeFromPersonsInDepartment(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsInDepartmentAtIndex:withObject:)
    @NSManaged func replacePersonsInDepartment(at idx: Int, with value: Person)

    @objc(replacePersonsInDepartmentAtIndexes:withPersonsInDepartment:)
    @NSManaged func replacePersonsInDepartment(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsInDepartmentObject:)
    @NSManaged func addToPersonsInDepartment(_ value: Person)

    @objc(removePersonsInDepartmentObject:)
    @NSManaged func removeFromPersonsInDepartment(_ value: Person)

    @objc(addPersonsInDepartment:)
    @NSManaged func addToPersonsInDepartment(_ values: NSOrderedSet)

    @objc(removePersonsInDepartment:)
    @NSManaged func removeFromPersonsInDepartment(_ values: NSOrderedSet)
}

extension Department: Identifiable {
    static func byYear(year: String) -> [Department] {
        let request: NSFetchRequest<Department> = Department.fetchRequest()

        request.predicate = NSPredicate(format: " ANY %K = %@", #keyPath(Department.personsInDepartment.year), year)

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    static func lineChartDepartment(_ departments: [DepartmentViewModel]) -> [ChartDataEntry] {
        let department = departments.reversed()

        return department.map { BarChartDataEntry(x: Double($0.year), y: $0.departmentAverageAnnualDouble) }
    }
}
