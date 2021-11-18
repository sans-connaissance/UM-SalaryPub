//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData

// this might work for all ListViewModels
class PersonListViewModel: ObservableObject {
    
    @Published var importYears = Person.importYears
    
    @Published var allPersons = [Int: [PersonViewModel]]()
    
    @Published var searchText = " "
    @Published var selectedYear: FetchYear = .twenty
    @Published var selectedNamePredicate: NamePredicateOrSort = .Person
    @Published var selectMoneyDescriptor: MoneySortDescriptor = .Person
    @Published var selectCountDescriptor: CountSortDescriptor = .Person
    @Published var selectYearByType: YearByType = .Person
    
    //change to MoneyAscending
    @Published var sortByMoneyDescending = true
    @Published var sortByMoneyAscending = false
    @Published var sortAlphabetically = false
    
    @Published var sortByPersonCountDescending = true
    @Published var sortByPersonCountAscending = false

    func personSearch() {
        let request: [Person] = Person.search(yearPredicate: String(selectedYear.rawValue),yearByType: selectYearByType.returnText, filterPredicate: searchText, sortByMoneyDescending: sortByMoneyDescending, sortByMoneyAscending: sortByMoneyAscending, moneySortDescriptor: selectMoneyDescriptor.returnText, sortAlphabetically: sortAlphabetically, namePredicateOrSort: selectedNamePredicate.returnText, sortByPersonCountDescending: false, leastPeopleSort: false, countSortDescriptor: selectCountDescriptor.returnText)
        allPersons[selectedYear.rawValue] = request.map(PersonViewModel.init)
        
    }
}

