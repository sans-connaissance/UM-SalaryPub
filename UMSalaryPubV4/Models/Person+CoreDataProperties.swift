//
//  Person+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Foundation
import CoreData

extension Person: BaseModel {

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
    

}

extension Person : Identifiable {
    
    static func byYear(year: String) -> NSFetchRequest<Person> {
        
        let fetchRequest: NSFetchRequest<Person> = NSFetchRequest<Person>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "year == \(year)")
        
        return fetchRequest
    }
    
}
