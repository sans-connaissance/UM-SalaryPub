//
//  PersonViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import CoreData
import Foundation

struct PersonViewModel: Hashable {
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
    
    var titleAverageAnnual: Double {
        return person.title!.titleAverageAnnual
    }
    
    var department: String {
        return person.department?.departmentName ?? ""
    }
    
    var departmentAverageAnnual: Double {
        return person.department!.departmentAverageAnnual
    }
    
    var campus: String {
        person.campus?.campusName ?? ""
    }
    
    var apptAnnualFTR: String {
        let apptAnnualFTR = person.apptAnnualFTR.withCommas()
        return "$" + apptAnnualFTR
    }
    
    var apptAnnualFTRInsight: String {
        let apptAnnualFTR = String(format: "%.2f", person.apptAnnualFTR)
        return "$" + apptAnnualFTR
    }
    
    var apptAnnualFTRDouble: Double {
        return person.apptAnnualFTR
    }
    
    var apptFTRBasis: String {
        person.apptFTRBasis ?? ""
    }
    
    var apptFraction: String {
        let formattedValue = String(format: "%.2f", person.apptFraction)
        return formattedValue
    }
    
    var amtSalaryFromGeneralFund: String {
        let amtSalaryFromGeneralFund = person.amtSalaryFromGeneralFund.withCommas()
        return "$" + amtSalaryFromGeneralFund
    }
}
