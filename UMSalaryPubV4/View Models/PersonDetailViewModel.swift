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
    
    func getTitle(vm: PersonViewModel) -> [TitleViewModel] {
        let request: [Title] = Title.forDetailViews(nameKeyPath: titleNameKP.returnText, yearKeyPath: titleYearKP.returnText, name: vm.title, year: vm.year)
        let titleForDetailView = request.map(TitleViewModel.init)
        return titleForDetailView
    }

    func getDepartment(vm: PersonViewModel) -> [DepartmentViewModel] {
        let request: [Department] = Department.forDetailViews(nameKeyPath: departmentNameKP.returnText, yearKeyPath: departmentYearKP.returnText, name: vm.department, year: vm.year)
        let departmentForDetailView = request.map(DepartmentViewModel.init)
        return departmentForDetailView
    }

    func getCampus(vm: PersonViewModel) -> [CampusViewModel] {
        let request: [Campus] = Campus.forDetailViews(nameKeyPath: campusNameKP.returnText, yearKeyPath: campusYearKP.returnText, name: vm.campus, year: vm.year)
        let campusForDetailView = request.map(CampusViewModel.init)
        return campusForDetailView
    }
    ///This function checks to make sure that the number of PersonViewModels per year is not greater than one.
    ///If it is greater than one, then it is not safe for the PersonDetailView to display the InsightsView button.
    func personInsightCheck(persons: [PersonViewModel]) -> Bool {
        var years: [Int64] = []
        let personsArray = persons
        for year in personsArray {
            years.append(year.year)
        }
        ///https://www.hackingwithswift.com/example-code/language/how-to-count-element-frequencies-in-an-array
        let mappedItems = years.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        let isGreatThanTwo = counts.contains(where: { $0.value > 1 })
        return !isGreatThanTwo
    }
}


