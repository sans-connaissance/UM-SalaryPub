//
//  AdminViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/23/21.
//

import Foundation
import CoreData


class AdminViewModel: ObservableObject {
    
    @Published var personsAll = [PersonViewModel]()
    @Published var persons2020 = [PersonViewModel]()
    @Published var persons2019 = [PersonViewModel]()
    @Published var persons2018 = [PersonViewModel]()
    @Published var persons2017 = [PersonViewModel]()
    @Published var persons2016 = [PersonViewModel]()
    @Published var persons2015 = [PersonViewModel]()
    @Published var persons2014 = [PersonViewModel]()
    @Published var persons2013 = [PersonViewModel]()
    
    
    
    
    
    
    
    @Published var titles = [TitleViewModel]()
    @Published var departments = [DepartmentViewModel]()
    @Published var campuses = [CampusViewModel]()
    
    
    
    
    
    
    func loadAdminScreen() {
        
        getAllPersons()
        getAllTitles()
        getAllDepartments()
    }
    

    
    func getAllTitles() {
        let titles: [Title] = Title.all()
        DispatchQueue.main.async {
            self.titles = titles.map(TitleViewModel.init)
        }
        
    }
    
    
    func getAllDepartments() {
        let departments: [Department] = Department.all()
        DispatchQueue.main.async {
            self.departments = departments.map(DepartmentViewModel.init)
        }
        
    }
    
    
    //MARK: ------------------------ Person ------------------------
    func getAllPersons() {
        
        let personsAll: [Person] = Person.all()
        DispatchQueue.main.async {
            self.personsAll = personsAll.map(PersonViewModel.init)
        }
    }
    

    func getPersons2020() {
        let persons2020: [Person] = Person.byYear(year: "2020")
        
        DispatchQueue.main.async {
            self.persons2020 = persons2020.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2019() {
        let persons2019: [Person] = Person.byYear(year: "2019")
        
        DispatchQueue.main.async {
            self.persons2019 = persons2019.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2018() {
        let persons2018: [Person] = Person.byYear(year: "2018")
        
        DispatchQueue.main.async {
            self.persons2018 = persons2018.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2017() {
        let persons2017: [Person] = Person.byYear(year: "2017")
        
        DispatchQueue.main.async {
            self.persons2017 = persons2017.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2016() {
        let persons2016: [Person] = Person.byYear(year: "2016")
        
        DispatchQueue.main.async {
            self.persons2016 = persons2016.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2015() {
        let persons2015: [Person] = Person.byYear(year: "2015")
        
        DispatchQueue.main.async {
            self.persons2015 = persons2015.map(PersonViewModel.init)
        }
        
    }
    
    func getPersons2014() {
        let persons2014: [Person] = Person.byYear(year: "2014")
        
        DispatchQueue.main.async {
            self.persons2014 = persons2014.map(PersonViewModel.init)
        }
        
    }
    
    
    func getPersons2013() {
        let persons2013: [Person] = Person.byYear(year: "2013")
        
        DispatchQueue.main.async {
            self.persons2013 = persons2013.map(PersonViewModel.init)
        }
        
    }
    
}

