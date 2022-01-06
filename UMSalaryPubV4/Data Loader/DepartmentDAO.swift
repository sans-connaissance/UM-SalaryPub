//
//  DepartmentDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//  Adapted from an example created by user intelcy on fiverr.com to assist with loading data from JSON files into CoreData persistentContainer
//

import CoreData
import Foundation

class DepartmentDAO: BaseDAO {
    static let shared = DepartmentDAO()
    private let departmentEntityName = "Department"
    
    func saveDepartmentIfNeeded(departmentName: String,
                                departmentYear: Int64,
                                departmentAverageAnnual: Double,
                                departmentMedianAnnual: Double,
                                departmentMaxAnnual: Double,
                                departmentMinAnnual: Double,
                                departmentCount: Double,
                                importYear: Int) -> Department
    {
        ///Ensures that only unique department records for each year are saved.
        ///This section was written by David Malicke.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: departmentEntityName)
        let importYear = importYear
        let yearPredicate = NSPredicate(format: "departmentYear = %i", importYear)
        let departmentNamePredicate = NSPredicate(format: "departmentName = %@", departmentName)
        let combinedDepartmentPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, departmentNamePredicate])
        fetchRequest.predicate = combinedDepartmentPredicate
        var department: Department?
        
        do {
            department = (try managedContext.fetch(fetchRequest) as! [Department]).first
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        guard department == nil else {
            return department!
        }
        
        let newDepartment = Department(context: managedContext)
        newDepartment.departmentName = departmentName
        newDepartment.departmentYear = departmentYear
        newDepartment.departmentAverageAnnual = departmentAverageAnnual
        newDepartment.departmentMedianAnnual = departmentMedianAnnual
        newDepartment.departmentMaxAnnual = departmentMaxAnnual
        newDepartment.departmentMinAnnual = departmentMinAnnual
        newDepartment.departmentCount = departmentCount
        return newDepartment
    }
}
