//
//  PersonDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import Foundation

class PersonDetailViewModel: ObservableObject {
    
    @Published var personsDetail = [PersonViewModel]()
    @Published var isPresented = false
    
    private var selectedKeyPath: NamePredicate = .Person
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: selectedKeyPath.returnText, name: vm.fullName)
        personsDetail = request.map(PersonViewModel.init)
        
    }
}

