//
//  CampusViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/18/21.
//

import CoreData
import Foundation

struct CampusViewModel: Hashable {
    let campus: Campus
    
    var id: NSManagedObjectID {
        return campus.objectID
    }
    
    var campusName: String {
        return campus.campusName ?? ""
    }
    
    var year: Int64 {
        campus.campusYear
    }
    
    var campusCount: String {
        let campusCount = campus.campusCount.noCommas()
        return campusCount
    }
    
    var campusAverageAnnual: String {
        let campusAverageAnnual = campus.campusAverageAnnual.withCommas()
        return "$" + campusAverageAnnual
    }
    
    var campusAverageAnnualDouble: Double {
        return campus.campusAverageAnnual
    }
    
    var campusMedianAnnual: String {
        let campusMedianAnnual = campus.campusMedianAnnual.withCommas()
        return "$" + campusMedianAnnual
    }
    
    var campusMaxAnnual: String {
        let campusMaxAnnual = campus.campusMaxAnnual.withCommas()
        return "$" + campusMaxAnnual
    }
    
    var campusMinAnnual: String {
        let campusMinAnnual = campus.campusMinAnnual.withCommas()
        return "$" + campusMinAnnual
    }
}
