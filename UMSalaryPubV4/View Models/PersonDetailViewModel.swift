//
//  PersonDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import Foundation

class PersonDetailViewModel: ObservableObject {
    
    @Published var personsDetail = [PersonViewModel]()
    @Published var selectedKeyPath: NamePredicate = .Person
    @Published var isPresented = false
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: selectedKeyPath.returnText, name: vm.fullName)
        personsDetail = request.map(PersonViewModel.init)
        
    }
}

