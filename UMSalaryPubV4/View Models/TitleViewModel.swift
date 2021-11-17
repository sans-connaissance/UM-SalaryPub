//
//  TitleViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import Foundation
import CoreData


struct TitleViewModel: Hashable {
    
    let title: Title
    
    var id: NSManagedObjectID {
        return title.objectID
    }
    
    var titleName: String {
        return title.titleName ?? ""
    }
    
    var year: Int64 {
        title.titleYear
    }
    
    var titleCount: String {
        let formattedValue = String(title.titleCount)
        return formattedValue
    }
    
    var titleAverageAnnual: String {
        let titleAverageAnnual = title.titleAverageAnnual.withCommas()
        return "$" + titleAverageAnnual
    }
    
}
