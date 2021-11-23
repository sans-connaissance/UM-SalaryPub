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
    @Published var campusesInsight = [CampusViewModel]()

    private var personsKP: NamePredicate = .Person
    private var titleNameKP: NamePredicate = .Title
    private var titleYearKP: YearByType = .Title
    private var departmentNameKP: NamePredicate = .Department
    private var departmentYearKP: YearByType = .Department
    private var campusNameKP: NamePredicate = .Campus
    private var campusYearKP: YearByType = .Campus
    
    
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: personsKP.returnText, name: vm.fullName)
        personsInsight = request.map(PersonViewModel.init)
    }
    
    func getTitles(vm: PersonViewModel) {
        let request: [Title] = Title.forInsights(nameKeyPath: titleNameKP.returnText, yearKeyPath: titleYearKP.returnText,  name: vm.title, year: vm.year)
        titlesInsight = request.map(TitleViewModel.init)
    }
    
    func getDepartments(vm: PersonViewModel) {
        let request: [Department] = Department.forInsights(nameKeyPath: departmentNameKP.returnText, yearKeyPath: departmentYearKP.returnText,  name: vm.title, year: vm.year)
        departmentsInsight = request.map(DepartmentViewModel.init)
        
    }
    
    func getCampuses(vm: PersonViewModel) {
        let request: [Campus] = Campus.forInsights(nameKeyPath: campusNameKP.returnText, yearKeyPath: campusNameKP.returnText,  name: vm.title, year: vm.year)
        campusesInsight = request.map(CampusViewModel.init)
        
    }

    func getPercentChange(array: [PersonViewModel]) {
        salaries = Person.personPercentChange(personsInsight)
        
    }
    
}