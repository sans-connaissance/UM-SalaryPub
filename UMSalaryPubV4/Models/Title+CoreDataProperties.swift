//
//  Title+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//
import Charts
import CoreData
import Foundation

extension Title: BaseModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Title> {
        return NSFetchRequest<Title>(entityName: "Title")
    }

    @NSManaged public var titleAnnArborAverage: Double
    @NSManaged public var titleAverageAnnual: Double
    @NSManaged public var titleCount: Double
    @NSManaged public var titleDearbornAverage: Double
    @NSManaged public var titleFlintAverage: Double
    @NSManaged public var titleMaxAnnual: Double
    @NSManaged public var titleMedianAnnual: Double
    @NSManaged public var titleMinAnnual: Double
    @NSManaged public var titleName: String?
    @NSManaged public var titleYear: Int64
    @NSManaged public var personsWithTitle: [Person]
}

// MARK: Generated accessors for personsWithTitle

public extension Title {
    @objc(insertObject:inPersonsWithTitleAtIndex:)
    @NSManaged func insertIntoPersonsWithTitle(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsWithTitleAtIndex:)
    @NSManaged func removeFromPersonsWithTitle(at idx: Int)

    @objc(insertPersonsWithTitle:atIndexes:)
    @NSManaged func insertIntoPersonsWithTitle(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsWithTitleAtIndexes:)
    @NSManaged func removeFromPersonsWithTitle(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsWithTitleAtIndex:withObject:)
    @NSManaged func replacePersonsWithTitle(at idx: Int, with value: Person)

    @objc(replacePersonsWithTitleAtIndexes:withPersonsWithTitle:)
    @NSManaged func replacePersonsWithTitle(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsWithTitleObject:)
    @NSManaged func addToPersonsWithTitle(_ value: Person)

    @objc(removePersonsWithTitleObject:)
    @NSManaged func removeFromPersonsWithTitle(_ value: Person)

    @objc(addPersonsWithTitle:)
    @NSManaged func addToPersonsWithTitle(_ values: NSOrderedSet)

    @objc(removePersonsWithTitle:)
    @NSManaged func removeFromPersonsWithTitle(_ values: NSOrderedSet)
}

extension Title: Identifiable {
    static func byYear(year: String) -> [Title] {
        let request: NSFetchRequest<Title> = Title.fetchRequest()

        request.predicate = NSPredicate(format: " ANY %K = %@", #keyPath(Title.personsWithTitle.year), year)

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    static func lineChartTitleAverage(_ titles: [TitleViewModel]) -> [ChartDataEntry] {
        let title = titles
        return title.map { BarChartDataEntry(x: Double($0.year), y: $0.titleAverageAnnualDouble) }
    }
}
