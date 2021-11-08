//
//  PersonViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import CoreData
import Foundation


struct PersonViewModel {
    
    let person: Person
    
    var id: NSManagedObjectID {
        person.objectID
    }
    
    var fullName: String {
        person.fullName ?? ""
    }
    
    var year: Int64 {
        person.year
    }
    
    var title: String {
        person.title?.titleName ?? ""
    }
    
    var department: String {
        person.department?.departmentName ?? ""
    }
    
    var campus: String {
        person.campus?.campusName ?? ""
    }
    
    var apptAnnualFTR: String {
        let formattedValue = String(format: "%.2f", person.apptAnnualFTR)
        return "$" + formattedValue
    }
    
    var apptFTRBasis: String {
        person.apptFTRBasis ?? ""
    }
    
    var apptFraction: String {
        let formattedValue = String(format: "%.2f", person.apptFraction)
        return formattedValue
    }
    
    var amtSalaryFromGeneralFund: String {
        let formattedValue = String(format: "%.2f", person.amtSalaryFromGeneralFund)
        return "$" + formattedValue
    }
    
}
