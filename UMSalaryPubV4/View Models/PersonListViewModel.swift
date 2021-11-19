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
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "
    @Published var sortByMoneyDescending = true
    @Published var sortByMoneyAscending = false
    @Published var sortAlphabetically = false
    @Published var sortByPersonCountDescending = false
    @Published var sortByPersonCountAscending = false
    
    private var yearByType: YearByType = .Person
    private var importYears = Person.importYears
    private var namePredicate: NamePredicate = .Person
    private var moneyDescriptor: MoneySortDescriptor = .Person
    private var countDescriptor: CountSortDescriptor = .Person

    func getPersons() {
        let request: [Person] = Person.search(
            byYear: String(year.rawValue),
            byType: yearByType.returnText,
            bySearchText: searchText,
            byNamePredicate: namePredicate.returnText,
            sortAlphabetically: sortAlphabetically,
            sortByMoneyDescending: sortByMoneyDescending,
            sortByMoneyAscending: sortByMoneyAscending,
            sortByPersonCountDescending: sortByPersonCountDescending,
            sortByPersonCountAscending: sortByPersonCountAscending,
            moneySortDescriptor: moneyDescriptor.returnText,
            countSortDescriptor: countDescriptor.returnText)
        
        allPersons[year.rawValue] = request.map(PersonViewModel.init)
        
    }
}

