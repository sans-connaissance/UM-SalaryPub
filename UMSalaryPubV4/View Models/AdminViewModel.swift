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
    
    @Published var titlesAll = [TitleViewModel]()
    @Published var titles2020 = [TitleViewModel]()
    @Published var titles2019 = [TitleViewModel]()
    @Published var titles2018 = [TitleViewModel]()
    @Published var titles2017 = [TitleViewModel]()
    @Published var titles2016 = [TitleViewModel]()
    @Published var titles2015 = [TitleViewModel]()
    @Published var titles2014 = [TitleViewModel]()
    @Published var titles2013 = [TitleViewModel]()
    
    @Published var departmentsAll = [DepartmentViewModel]()
    @Published var departments2020 = [DepartmentViewModel]()
    @Published var departments2019 = [DepartmentViewModel]()
    @Published var departments2018 = [DepartmentViewModel]()
    @Published var departments2017 = [DepartmentViewModel]()
    @Published var departments2016 = [DepartmentViewModel]()
    @Published var departments2015 = [DepartmentViewModel]()
    @Published var departments2014 = [DepartmentViewModel]()
    @Published var departments2013 = [DepartmentViewModel]()
    
    @Published var campusesAll = [CampusViewModel]()
    @Published var campuses2020 = [CampusViewModel]()
    @Published var campuses2019 = [CampusViewModel]()
    @Published var campuses2018 = [CampusViewModel]()
    @Published var campuses2017 = [CampusViewModel]()
    @Published var campuses2016 = [CampusViewModel]()
    @Published var campuses2015 = [CampusViewModel]()
    @Published var campuses2014 = [CampusViewModel]()
    @Published var campuses2013 = [CampusViewModel]()
    
    
    func loadAdminScreen() {
        
        getAllPersons()
        getAllTitles()
        getAllDepartments()
        
        getPersons2020()
        
        getTitles2020()
        
        getDepartments2020()
        
        
        getCampuses2020()
    }
    

    
    func getAllTitles() {
        let titlesAll: [Title] = Title.all()
        DispatchQueue.main.async {
            self.titlesAll = titlesAll.map(TitleViewModel.init)
        }
        
    }
    
    
    func getAllDepartments() {
        let departmentsAll: [Department] = Department.all()
        DispatchQueue.main.async {
            self.departmentsAll = departmentsAll.map(DepartmentViewModel.init)
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
    
    
    //MARK: ------------------------ Titles ------------------------
    
    func getTitles2020() {
        let titles2020: [Title] = Title.byYear(year: "2020")
        
        DispatchQueue.main.async {
            self.titles2020 = titles2020.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2019() {
        let titles2020: [Title] = Title.byYear(year: "2019")
        
        DispatchQueue.main.async {
            self.titles2020 = titles2020.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2018() {
        let titles2018: [Title] = Title.byYear(year: "2018")
        
        DispatchQueue.main.async {
            self.titles2018 = titles2018.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2017() {
        let titles2017: [Title] = Title.byYear(year: "2017")
        
        DispatchQueue.main.async {
            self.titles2017 = titles2017.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2016() {
        let titles2016: [Title] = Title.byYear(year: "2016")
        
        DispatchQueue.main.async {
            self.titles2016 = titles2016.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2015() {
        let titles2015: [Title] = Title.byYear(year: "2015")
        
        DispatchQueue.main.async {
            self.titles2015 = titles2015.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2014() {
        let titles2014: [Title] = Title.byYear(year: "2014")
        
        DispatchQueue.main.async {
            self.titles2014 = titles2014.map(TitleViewModel.init)
        }
        
    }
    
    func getTitles2013() {
        let titles2013: [Title] = Title.byYear(year: "2013")
        
        DispatchQueue.main.async {
            self.titles2013 = titles2013.map(TitleViewModel.init)
        }
        
    }
    

    
    //MARK: ------------------------ Departments ---------------------

    func getDepartments2020() {
        let departments2020: [Department] = Department.byYear(year: "2020")
        
        DispatchQueue.main.async {
            self.departments2020 = departments2020.map(DepartmentViewModel.init)
        }
        
    }
    
    
    
    //MARK: ------------------------ Campuses ---------------------
    
    func getCampuses2020() {
        let campuses2020: [Campus] = Campus.byYear(year: "2020")
        
        DispatchQueue.main.async {
            self.campuses2020 = campuses2020.map(CampusViewModel.init)
        }
        
    }
    
    
    
}

