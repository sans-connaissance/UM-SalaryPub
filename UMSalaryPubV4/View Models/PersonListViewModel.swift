//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData




enum SortYear: Int64, CaseIterable {
    
    case twenty = 2020
    case nineteen = 2019
    
    var displayText: String {
        
        switch self {
        case .twenty:
            return "2020"
        case .nineteen:
            return "2019"
            
        }
    }
}

class PersonListViewModel: ObservableObject {
    
    // This is where I need to add all the filters and stuff I think
    
    
    @Published var persons = [PersonViewModel]()
    
    func getAllPersons() {
        
        let personViewModel: [Person] = Person.byYear(year: String(2020))
        persons = personViewModel.map(PersonViewModel.init)
        
    }
    
}
