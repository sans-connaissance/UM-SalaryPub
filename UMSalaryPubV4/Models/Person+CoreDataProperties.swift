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
    
    static func byYear(year: String, moneySort: Bool, alphabetSort: Bool) -> [Person] {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
       
        let mostMoneySortDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: false)
        let leastMoneySortDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: true)
        let alphabetSortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
        
        if moneySort { request.sortDescriptors = [mostMoneySortDescriptor] }
        if !moneySort { request.sortDescriptors = [leastMoneySortDescriptor] }
        if alphabetSort { request.sortDescriptors = [alphabetSortDescriptor] }

        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Person.year), year)
        
        

 
            
        request.fetchBatchSize = 20
        request.fetchLimit = 50
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}
