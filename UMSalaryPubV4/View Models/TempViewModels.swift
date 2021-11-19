//
//  TempViewModels.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/2/21.
//

import Foundation
import CoreData




struct CampusViewModel {
    
    let campus: Campus
    
    var id: NSManagedObjectID {
        return campus.objectID
    }
    
    var campusName: String {
        return campus.campusName ?? ""
    }
    
}




