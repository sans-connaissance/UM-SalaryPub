//
//  AdminViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/23/21.
//

import Foundation
import CoreData


class AdminViewModel: ObservableObject {
    
    @Published var persons = [PersonViewModel]()
    
    func getAllPersons() {
        let persons = CoreDataManager.shared.getAllPersons()
        DispatchQueue.main.async {
            self.persons = persons.map(PersonViewModel.init)
        }
        
        
    }
    
    
}


struct PersonViewModel {
    
    let person: Person
    
    var id: NSManagedObjectID {
        return person.objectID
    }
    
    var fullName: String {
        
        return person.fullName ?? ""
    }
    
}
