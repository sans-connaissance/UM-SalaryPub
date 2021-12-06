//
//  PersonDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import Foundation

class PersonDetailViewModel: ObservableObject {
    @Published var personsDetail = [PersonViewModel]()
    @Published var campusForDetailView = [CampusViewModel]()
    @Published var isPresented = false
   
    private var selectedKeyPath: NamePredicate = .Person
    private var personsKP: NamePredicate = .Person
    private var titleNameKP: NamePredicate = .Title
    private var titleYearKP: YearByType = .Title
    private var departmentNameKP: NamePredicate = .Department
    private var departmentYearKP: YearByType = .Department
    private var campusNameKP: NamePredicate = .Campus
    private var campusYearKP: YearByType = .Campus

    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: selectedKeyPath.returnText, name: vm.fullName)
        personsDetail = request.map(PersonViewModel.init)
    }
    
    func getCampus(vm: PersonViewModel) {
        let request: [Campus] = Campus.forInsights(nameKeyPath: campusNameKP.returnText, yearKeyPath: campusYearKP.returnText, name: vm.campus, year: vm.year)
        campusForDetailView = request.map(CampusViewModel.init)
    }
    
}
