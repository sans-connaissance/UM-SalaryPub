//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class PersonInsightViewModel: ObservableObject {
    
    @Published var personsInsight = [PersonViewModel]()
    @Published var salaries = [Double]()
    @Published var titlesInsight = [TitleViewModel]()
    @Published var departmentsInsight = [DepartmentViewModel]()
    
    
    
    private var personsKeyPath: NamePredicate = .Person
    private var titleNameKP: NamePredicate = .Title
    private var titleYearKP: YearByType = .Title
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: personsKeyPath.returnText, name: vm.fullName)
        personsInsight = request.map(PersonViewModel.init)
    }
    
// need to add another one for the name or year predicate in the baseClass
    func getTitles(vm: PersonViewModel) {
        let request: [Title] = Title.forInsights(nameKeyPath: titleNameKP.returnText, yearKeyPath: titleYearKP.returnText,  name: vm.title, year: vm.year)
        titlesInsight = request.map(TitleViewModel.init)
    }
    
    
    
    func getPercentChange(array: [PersonViewModel]) {
        salaries = Person.personPercentChange(personsInsight)
        
    }
    
}
