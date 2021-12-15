//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Charts
import Foundation

class PersonInsightViewModel: ObservableObject {
    @Published var personsInsight = [PersonViewModel]()
    @Published var salaries = [Double]()
    @Published var titlesInsight = [TitleViewModel]()
    @Published var departmentsInsight = [DepartmentViewModel]()
    @Published var campusesInsight = [CampusViewModel]()
    
    @Published var showTitleAverage = false
    @Published var showDepartmentAverage = false
    @Published var showCampusAverage = true
    @Published var showAnnualFTR = true
    
    @Published var personEntryAnnualFTR = [ChartDataEntry]()
    @Published var personEntryTitleAverageAnnual = [ChartDataEntry]()
    @Published var personEntryDepartmentAverageAnnual = [ChartDataEntry]()
    @Published var personEntryCampusAverageAnnual = [ChartDataEntry]()

    private var personsKP: NamePredicate = .Person
    private var titleNameKP: NamePredicate = .Title
    private var titleYearKP: YearByType = .Title
    private var departmentNameKP: NamePredicate = .Department
    private var departmentYearKP: YearByType = .Department
    private var campusNameKP: NamePredicate = .Campus
    private var campusYearKP: YearByType = .Campus
    
    var personCount: Int {
        return personsInsight.count
    }
    
    var titleCount: Int {
        return titlesInsight.count
    }
    
    var departmentCount: Int {
        return departmentsInsight.count
    }
    
    var campusCount: Int {
        return campusesInsight.count
    }
    
    func getPersons(vm: PersonViewModel) {
        let request: [Person] = Person.byName(keyPath: personsKP.returnText, name: vm.fullName)
        personsInsight = request.map(PersonViewModel.init)
    }
    
    func getTitles(vm: PersonViewModel, year: Int64) {
        let request: [Title] = Title.forDetailViews(nameKeyPath: titleNameKP.returnText, yearKeyPath: titleYearKP.returnText, name: vm.title, year: year)
        titlesInsight = request.map(TitleViewModel.init)
    }
    
    func getDepartments(vm: PersonViewModel, year: Int64) {
        let request: [Department] = Department.forDetailViews(nameKeyPath: departmentNameKP.returnText, yearKeyPath: departmentYearKP.returnText, name: vm.department, year: year)
        departmentsInsight = request.map(DepartmentViewModel.init)
    }
    
    func getCampuses(vm: PersonViewModel, year: Int64) {
        let request: [Campus] = Campus.forDetailViews(nameKeyPath: campusNameKP.returnText, yearKeyPath: campusYearKP.returnText, name: vm.campus, year: year)
        campusesInsight = request.map(CampusViewModel.init)
    }
    
    func getPercentChange() {
        salaries = Person.personPercentChange(personsInsight)
    }

    func getChartData() {
        personEntryAnnualFTR = Person.lineChartAnnualFTR(personsInsight)
        personEntryTitleAverageAnnual = Title.lineChartTitleAverage(titlesInsight)
        personEntryDepartmentAverageAnnual = Department.lineChartDepartment(departmentsInsight)
        personEntryCampusAverageAnnual = Campus.lineChartDepartmentAverage(campusesInsight)
    }
}
