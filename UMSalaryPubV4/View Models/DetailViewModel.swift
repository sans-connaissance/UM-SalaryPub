//
//  PersonDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    
    @Published var personsDetail = [PersonViewModel]()
    @Published var selectedKeyPath: NamePredicateOrSort = .Person
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.by(keyPath: selectedKeyPath.returnText, name: vm.fullName)
        personsDetail = request.map(PersonViewModel.init)
        
    }
}

