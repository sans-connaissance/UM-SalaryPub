//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData


class PersonListViewModel: ObservableObject {
    

    
    @Published var allPersons = [Int: [PersonViewModel]]()
    @Published var importYears = Person.importYears
    @Published var selectedSortYear: FetchYear = .twenty
//    @Published var selectedSortYear = Person.importYears.last
    @Published var searchText = " "
    
    @Published var mostMoneySort = true
    @Published var leastMoneySort = false
    @Published var alphabetSort = false
    

    func personsByYear() {
        let request: [Person] = Person.byYear(year: String(selectedSortYear.rawValue), mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, alphabetSort: alphabetSort, filter: searchText)
        allPersons[selectedSortYear.rawValue] = request.map(PersonViewModel.init)
    }
}



//
//        for year in importYears {
//            let request: [Person] = Person.byYear(year: String(year), mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, alphabetSort: alphabetSort, filter: searchText)
//            allPersons[year] = request.map(PersonViewModel.init)
//        }
//    }
