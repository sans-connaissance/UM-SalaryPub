//
//  Person+CoreDataProperties.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//
//

import Charts
import CoreData
import Foundation
import SwiftUI

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

extension Person: Identifiable {

    /// This func is only used in the AdminViewModel.
    // MARK TO DO: create BaseModel.byYear func to replace this
    static func byYear(year: String, sortByMoneyDescending: Bool, sortByMoneyAscending: Bool, sortAlphabetically: Bool, filter: String) -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()

        let sortByMoneyDescendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: false)
        let sortByMoneyAscendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: true)
        let sortAlphabeticallyDescriptor = NSSortDescriptor(key: "fullName", ascending: true)

        if sortByMoneyDescending { request.sortDescriptors = [sortByMoneyDescendingDescriptor] }
        if sortByMoneyAscending { request.sortDescriptors = [sortByMoneyAscendingDescriptor] }
        if sortAlphabetically { request.sortDescriptors = [sortAlphabeticallyDescriptor] }

        let yearPredicate = NSPredicate(format: "year == %@", year)
        let namePredicate = NSPredicate(format: "fullName CONTAINS[c] %@", filter)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        request.predicate = combinedPredicate

        request.fetchBatchSize = 25
        //request.fetchLimit = 50

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    /// Fetches and sorts all  people by a selected  title. Used in the PersonListByTitleViewModel
    static func byTitle(year: String, titleName: String, sortByMoneyDescending: Bool, sortByMoneyAscending: Bool, sortAlphabetically: Bool) -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        let sortByMoneyDescendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: false)
        let sortByMoneyAscendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: true)
        let sortAlphabeticallyDescriptor = NSSortDescriptor(key: "fullName", ascending: true)

        if sortByMoneyDescending { request.sortDescriptors = [sortByMoneyDescendingDescriptor] }
        if sortByMoneyAscending { request.sortDescriptors = [sortByMoneyAscendingDescriptor] }
        if sortAlphabetically { request.sortDescriptors = [sortAlphabeticallyDescriptor] }

        let yearPredicate = NSPredicate(format: "year == %@", year)
        let namePredicate = NSPredicate(format: "ANY title.titleName = %@", titleName)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        request.predicate = combinedPredicate
        
        request.fetchBatchSize = 25
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    /// Fetches and sorts all  people by selected department. Used in the PersonListByDepartmentViewModel
    static func byDepartment(year: String, departmentName: String, sortByMoneyDescending: Bool, sortByMoneyAscending: Bool, sortAlphabetically: Bool) -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        let sortByMoneyDescendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: false)
        let sortByMoneyAscendingDescriptor = NSSortDescriptor(key: "apptAnnualFTR", ascending: true)
        let sortAlphabeticallyDescriptor = NSSortDescriptor(key: "fullName", ascending: true)

        if sortByMoneyDescending { request.sortDescriptors = [sortByMoneyDescendingDescriptor] }
        if sortByMoneyAscending { request.sortDescriptors = [sortByMoneyAscendingDescriptor] }
        if sortAlphabetically { request.sortDescriptors = [sortAlphabeticallyDescriptor] }

        let yearPredicate = NSPredicate(format: "year == %@", year)
        let namePredicate = NSPredicate(format: "ANY department.departmentName = %@", departmentName)
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, namePredicate])
        request.predicate = combinedPredicate
        request.fetchBatchSize = 25
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    ///Calculates the yearly percent change of a person's reported Annual Full-Time Rate (FTR)
    static func personPercentChange(_ persons: [PersonViewModel]) -> [Double] {
        var salaries: [Double] = []
        let personsArray = persons

        for salary in personsArray {
            salaries.append(salary.apptAnnualFTRDouble)
        }

        ///https://stackoverflow.com/questions/52155931/creating-an-array-based-on-the-percentage-difference-of-each-values-of-a-previou
        let percentages = [0] + zip(salaries, salaries.dropFirst()).map {
            100.0 * ($1 - $0) / $0
        }
        return percentages
    }

    ///Creates a data array that can be used to add points to Charts : line charts
    static func lineChartAnnualFTR(_ persons: [PersonViewModel]) -> [ChartDataEntry] {
        let personArray = persons
        return personArray.map { BarChartDataEntry(x: Double($0.year), y: $0.apptAnnualFTRDouble) }
    }
}
