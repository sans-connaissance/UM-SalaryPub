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
    @Published var titles = [TitleViewModel]()
    
    
    func getAllPersons() {
        
        let persons: [Person] = Person.all()
        DispatchQueue.main.async {
            self.persons = persons.map(PersonViewModel.init)
        }
    }

    
    func getAllTitles() {
        let titles: [Title] = Title.all()
        DispatchQueue.main.async {
            self.titles = titles.map(TitleViewModel.init)
        }
        
    }
    
    var titleCount: Int {
        return titles.count
    }
    
    
    var personCount: Int {
        return persons.count
    }
    
}




struct TitleViewModel {
    
    let title: Title
    
    var id: NSManagedObjectID {
        return title.objectID
    }
    
    var titleName: String {
        return title.titleName ?? ""
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
    
    var title: String {
        
        return person.title?.titleName ?? ""
        
    }
    
    var salary: String {
        
        return "$" + String(person.apptAnnualFTR)
    }
    
}
