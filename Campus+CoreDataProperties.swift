//
//  Campus+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Foundation
import CoreData


extension Campus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Campus> {
        return NSFetchRequest<Campus>(entityName: "Campus")
    }

    @NSManaged public var campusAnnArborAverage: Double
    @NSManaged public var campusAverageAnnual: Double
    @NSManaged public var campusCount: Double
    @NSManaged public var campusDearbornAverage: Double
    @NSManaged public var campusFlintAverage: Double
    @NSManaged public var campusMaxAnnual: Double
    @NSManaged public var campusMedianAnnual: Double
    @NSManaged public var campusMinAnnual: Double
    @NSManaged public var campusName: String?
    @NSManaged public var campusYear: Int64
    @NSManaged public var personsOnCampus: Array<Person>
    

}

// MARK: Generated accessors for personsOnCampus
extension Campus {

    @objc(insertObject:inPersonsOnCampusAtIndex:)
    @NSManaged public func insertIntoPersonsOnCampus(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsOnCampusAtIndex:)
    @NSManaged public func removeFromPersonsOnCampus(at idx: Int)

    @objc(insertPersonsOnCampus:atIndexes:)
    @NSManaged public func insertIntoPersonsOnCampus(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsOnCampusAtIndexes:)
    @NSManaged public func removeFromPersonsOnCampus(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsOnCampusAtIndex:withObject:)
    @NSManaged public func replacePersonsOnCampus(at idx: Int, with value: Person)

    @objc(replacePersonsOnCampusAtIndexes:withPersonsOnCampus:)
    @NSManaged public func replacePersonsOnCampus(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsOnCampusObject:)
    @NSManaged public func addToPersonsOnCampus(_ value: Person)

    @objc(removePersonsOnCampusObject:)
    @NSManaged public func removeFromPersonsOnCampus(_ value: Person)

    @objc(addPersonsOnCampus:)
    @NSManaged public func addToPersonsOnCampus(_ values: NSOrderedSet)

    @objc(removePersonsOnCampus:)
    @NSManaged public func removeFromPersonsOnCampus(_ values: NSOrderedSet)

}

extension Campus : Identifiable {

}
