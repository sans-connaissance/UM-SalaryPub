//
//  PersonDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import Foundation

class PersonDetailViewModel: ObservableObject {
    
    
    @Published var personsDetail = [PersonViewModel]()
    @Published var selectedKeyPath: NameKeyPath = .Person
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.by(keyPath: selectedKeyPath.returnText, name: vm.fullName)
        personsDetail = request.map(PersonViewModel.init)
        
    }
}

