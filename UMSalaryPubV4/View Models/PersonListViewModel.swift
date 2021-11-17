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
    
    @Published var mostMoneySort = true
    @Published var leastMoneySort = false
    @Published var alphabetSort = false
    
    @Published var mostPeopleSort = true
    @Published var leastPeopleSort = false
    
//    init(selectedNamePredicate: NamePredicateOrSort, selectMoneyDescriptor: MoneySortDescriptor, selectCountDescriptor: CountSortDescriptor) {
//        self.selectedNamePredicate = selectedNamePredicate
//        self.selectMoneyDescriptor = selectMoneyDescriptor
//        self.selectCountDescriptor = selectCountDescriptor
//
//    }

    func personSearch() {
        let request: [Person] = Person.search(yearPredicate: String(selectedYear.rawValue), filterPredicate: searchText, mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, moneySortDescriptor: selectMoneyDescriptor.returnText, alphabetSort: alphabetSort, namePredicateOrSort: selectedNamePredicate.returnText, mostPeopleSort: false, leastPeopleSort: false, countSortDescriptor: selectCountDescriptor.returnText)
        allPersons[selectedYear.rawValue] = request.map(PersonViewModel.init)
        
    }
}

