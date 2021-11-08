//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData

class PersonListViewModel: ObservableObject {
    
    @Published var persons = [PersonViewModel]()
    
    func getAllPersons() {
        
        let personViewModel: [Person] = Person.byYear(year: String(2020))
        persons = personViewModel.map(PersonViewModel.init)
        
    }
    
}
