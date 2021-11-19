//
//  DepartmentViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/18/21.
//

import CoreData
import Foundation

struct DepartmentViewModel: Hashable {
    
    let department: Department
    
    var id: NSManagedObjectID {
        return department.objectID
    }
    
    var departmentName: String {
        return department.departmentName ?? ""
    }
    
    var departmentAverageAnnual: String {
        let departmentAverageAnnual = department.departmentAverageAnnual.withCommas()
        return "$" + departmentAverageAnnual
    }
    
    var departmentMedianAnnual: String {
        let departmentMedianAnnual = department.departmentAverageAnnual.withCommas()
        return "$" + departmentMedianAnnual
    }
    
    var departmentMaxAnnual: String {
        let departmentMaxAnnual = department.departmentMaxAnnual.withCommas()
        return "$" + departmentMaxAnnual
    }
    
    var departmentMinAnnual: String {
        let departmentMinAnnual = department.departmentMinAnnual.withCommas()
        return "$" + departmentMinAnnual
    }
    
}
