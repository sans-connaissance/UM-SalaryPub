//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData


class PersonListViewModel: ObservableObject {
    
    @Published var importYears = Person.importYears
    @Published var allPersons = [Int: [PersonViewModel]]()
    
    @Published var searchText = " "
    @Published var selectedYear: FetchYear = .twenty
    @Published var selectedNamePredicate: NamePredicateOrSort = .Person
    @Published var selectMoneyDescriptor: MoneySortDescriptor = .Person
    
    @Published var mostMoneySort = true
    @Published var leastMoneySort = false
    @Published var alphabetSort = false
    

    func personsByYear() {
        let request: [Person] = Person.byYear(year: String(selectedYear.rawValue), mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, alphabetSort: alphabetSort, filter: searchText)
        allPersons[selectedYear.rawValue] = request.map(PersonViewModel.init)
    }
    
    func personSearch() {
        let request: [Person] = Person.search(yearPredicate: String(selectedYear.rawValue), filterPredicate: searchText, mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, moneySortDescriptor: selectMoneyDescriptor.returnText, alphabetSort: alphabetSort, namePredicateOrSort: selectedNamePredicate.returnText, mostPeopleSort: false, leastPeopleSort: false, countSortDescriptor: "")
        allPersons[selectedYear.rawValue] = request.map(PersonViewModel.init)
        
    }
}



//
//        for year in importYears {
//            let request: [Person] = Person.byYear(year: String(year), mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, alphabetSort: alphabetSort, filter: searchText)
//            allPersons[year] = request.map(PersonViewModel.init)
//        }
//    }
