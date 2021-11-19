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
        let titleCount = title.titleCount.withCommas()
        return titleCount
    }
    
    var titleAverageAnnual: String {
        let titleAverageAnnual = title.titleAverageAnnual.withCommas()
        return "$" + titleAverageAnnual
    }
    
    var titleMedianAnnual: String {
        let titleMedianAnnual = title.titleMedianAnnual.withCommas()
        return "$" + titleMedianAnnual
    }
    
    var titleMaxAnnual: String {
        let titleMaxAnnual = title.titleMaxAnnual.withCommas()
        return "$" + titleMaxAnnual
    }
    
    var titleMinAnnual: String {
        let titleMinAnnual = title.titleMinAnnual.withCommas()
        return "$" + titleMinAnnual
    }
    
}
