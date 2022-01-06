//
//  Campus+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Charts
import CoreData
import Foundation

extension Campus: BaseModel {
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
    @NSManaged public var personsOnCampus: [Person]
}

// MARK: Generated accessors for personsOnCampus

public extension Campus {
    @objc(insertObject:inPersonsOnCampusAtIndex:)
    @NSManaged func insertIntoPersonsOnCampus(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsOnCampusAtIndex:)
    @NSManaged func removeFromPersonsOnCampus(at idx: Int)

    @objc(insertPersonsOnCampus:atIndexes:)
    @NSManaged func insertIntoPersonsOnCampus(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsOnCampusAtIndexes:)
    @NSManaged func removeFromPersonsOnCampus(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsOnCampusAtIndex:withObject:)
    @NSManaged func replacePersonsOnCampus(at idx: Int, with value: Person)

    @objc(replacePersonsOnCampusAtIndexes:withPersonsOnCampus:)
    @NSManaged func replacePersonsOnCampus(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsOnCampusObject:)
    @NSManaged func addToPersonsOnCampus(_ value: Person)

    @objc(removePersonsOnCampusObject:)
    @NSManaged func removeFromPersonsOnCampus(_ value: Person)

    @objc(addPersonsOnCampus:)
    @NSManaged func addToPersonsOnCampus(_ values: NSOrderedSet)

    @objc(removePersonsOnCampus:)
    @NSManaged func removeFromPersonsOnCampus(_ values: NSOrderedSet)
}

extension Campus: Identifiable {
    
    /// This func is only used in the AdminViewModel.
    // MARK TO DO: create BaseModel.byYear func to replace this
    static func byYear(year: String) -> [Campus] {
        let request: NSFetchRequest<Campus> = Campus.fetchRequest()
        request.predicate = NSPredicate(format: " ANY %K = %@", #keyPath(Campus.personsOnCampus.year), year)

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    ///Creates a data array that can be used to add points to Charts : line charts
    static func lineChartCampusAverage(_ campuses: [CampusViewModel]) -> [ChartDataEntry] {
        let campus = campuses
        return campus.map { BarChartDataEntry(x: Double($0.year), y: $0.campusAverageAnnualDouble) }
    }
}
