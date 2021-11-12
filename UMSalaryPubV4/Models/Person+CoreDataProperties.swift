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
    
    static func byYear(year: String, moneySort: Bool) -> [Person] {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        let mostMoneySort = NSSortDescriptor(key: "apptAnnualFTR", ascending: false)
        let leastMoneySort = NSSortDescriptor(key: "apptAnnualFTR", ascending: true)
        
        request.fetchBatchSize = 20
        request.fetchLimit = 50

        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Person.year), year)
        
        if moneySort {
            request.sortDescriptors = [mostMoneySort]
        } else {
            request.sortDescriptors = [leastMoneySort]
        }
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}
