//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class PersonInsightViewModel: ObservableObject {
    
    @Published var personsInsight = [PersonViewModel]()
    @Published var personsKeyPath: NamePredicate = .Person
    
    @Published var titles = [TitleViewModel]()
    @Published var titlesKeyPath: NamePredicate = .Title
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: personsKeyPath.returnText, name: vm.fullName)
        personsInsight = request.map(PersonViewModel.init)
    }
    

    
    func getTitles(vm: TitleViewModel) {
        let request: [Title] = Title.byName(keyPath: titlesKeyPath.returnText, name: vm.titleName)
        titles = request.map(TitleViewModel.init)
        
    }
    
    
}
