//
//  DepartmentDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//

import Foundation
import CoreData

class DepartmentDAO: BaseDAO {
    
    // Singleton object
    static let shared = DepartmentDAO()
    
    private let departmentEntityName = "Department"
    
    func saveDepartmentIfNeeded(departmentName: String,
                                departmentYear: Int64,
                                departmentAverageAnnual: Double,
                                departmentMedianAnnual: Double,
                                departmentMaxAnnual: Double,
                                departmentMinAnnual: Double,
                                departmentCount: Double,
                                importYear: Int) -> Department {
        
        
        
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
            // Returning category if available in database
            return department!
        }
        
        // Creating category object in database
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
