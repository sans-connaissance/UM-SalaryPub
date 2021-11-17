//
//  TempViewModels.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/2/21.
//

import Foundation
import CoreData



struct DepartmentViewModel {
    
    let department: Department
    
    var id: NSManagedObjectID {
        return department.objectID
    }
    
    var departmentName: String {
        return department.departmentName ?? ""
    }
    
}

struct CampusViewModel {
    
    let campus: Campus
    
    var id: NSManagedObjectID {
        return campus.objectID
    }
    
    var campusName: String {
        return campus.campusName ?? ""
    }
    
}




