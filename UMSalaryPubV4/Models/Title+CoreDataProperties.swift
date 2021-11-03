//
//  Title+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Foundation
import CoreData


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
    @NSManaged public var personsWithTitle: Array<Person>

}

// MARK: Generated accessors for personsWithTitle
extension Title {

    @objc(insertObject:inPersonsWithTitleAtIndex:)
    @NSManaged public func insertIntoPersonsWithTitle(_ value: Person, at idx: Int)

    @objc(removeObjectFromPersonsWithTitleAtIndex:)
    @NSManaged public func removeFromPersonsWithTitle(at idx: Int)

    @objc(insertPersonsWithTitle:atIndexes:)
    @NSManaged public func insertIntoPersonsWithTitle(_ values: [Person], at indexes: NSIndexSet)

    @objc(removePersonsWithTitleAtIndexes:)
    @NSManaged public func removeFromPersonsWithTitle(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsWithTitleAtIndex:withObject:)
    @NSManaged public func replacePersonsWithTitle(at idx: Int, with value: Person)

    @objc(replacePersonsWithTitleAtIndexes:withPersonsWithTitle:)
    @NSManaged public func replacePersonsWithTitle(at indexes: NSIndexSet, with values: [Person])

    @objc(addPersonsWithTitleObject:)
    @NSManaged public func addToPersonsWithTitle(_ value: Person)

    @objc(removePersonsWithTitleObject:)
    @NSManaged public func removeFromPersonsWithTitle(_ value: Person)

    @objc(addPersonsWithTitle:)
    @NSManaged public func addToPersonsWithTitle(_ values: NSOrderedSet)

    @objc(removePersonsWithTitle:)
    @NSManaged public func removeFromPersonsWithTitle(_ values: NSOrderedSet)

}

extension Title : Identifiable {
    
    
    static func byYear(year: String) -> [Title] {
        
        let request: NSFetchRequest<Title> = Title.fetchRequest()
        
        request.predicate = NSPredicate(format: " ANY %K = %@", #keyPath(Title.personsWithTitle.year), year)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

}
