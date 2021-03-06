//
//  AdminViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/23/21.
//

import CoreData
import Foundation

///This view model is used to load data into the DataDashboard and DashboardCounts views
class AdminViewModel: ObservableObject {
    @Published var importYears = Person.importYears
    @Published var allPersons = [Int: [PersonViewModel]]()
    @Published var allTitles = [Int: [TitleViewModel]]()
    @Published var allDepartments = [Int: [DepartmentViewModel]]()
    @Published var allCampuses = [Int: [CampusViewModel]]()
    
    func loadAdminScreen() {
        getAllPersons()
        getAllTitles()
        getAllDepartments()
        getAllCampuses()
    }
    
    func getAllPersons() {
        for year in importYears {
            let personViewModel: [Person] = Person.byYear(year: String(year), sortByMoneyDescending: true, sortByMoneyAscending: true, sortAlphabetically: true, filter: " ")
            allPersons[year] = personViewModel.map(PersonViewModel.init)
        }
    }
    
    func getAllTitles() {
        for year in importYears {
            let titleViewModel: [Title] = Title.byYear(year: String(year))
            allTitles[year] = titleViewModel.map(TitleViewModel.init)
        }
    }
    
    func getAllDepartments() {
        for year in importYears {
            let departmentViewModel: [Department] = Department.byYear(year: String(year))
            allDepartments[year] = departmentViewModel.map(DepartmentViewModel.init)
        }
    }
    
    func getAllCampuses() {
        for year in importYears {
            let campusViewModel: [Campus] = Campus.byYear(year: String(year))
            allCampuses[year] = campusViewModel.map(CampusViewModel.init)
        }
    }
}
