//
//  TitleListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import Foundation
import CoreData

class TitleListViewModel: ObservableObject {

    @Published var allTitles = [Int: [TitleViewModel]]()
    @Published var searchText = " "
    @Published var sortByMoneyDescending = false
    @Published var sortByMoneyAscending = false
    @Published var sortAlphabetically = false
    @Published var sortByPersonCountDescending = true
    @Published var sortByPersonCountAscending = false
    @Published var selectedYear: FetchYear = .twenty
    
    private var importYears = Title.importYears
    private var selectedNamePredicate: NamePredicateOrSort = .Title
    private var selectMoneyDescriptor: MoneySortDescriptor = .Title
    private var selectCountDescriptor: CountSortDescriptor = .Title
    private var selectYearByType: YearByType = .Title
    

    func titleSearch() {
        let request: [Title] = Title.search(yearPredicate: String(selectedYear.rawValue), yearByType: selectYearByType.returnText, filterPredicate: searchText, sortByMoneyDescending: sortByMoneyDescending, sortByMoneyAscending: sortByMoneyAscending, moneySortDescriptor: selectMoneyDescriptor.returnText, sortAlphabetically: sortAlphabetically, namePredicateOrSort: selectedNamePredicate.returnText, sortByPersonCountDescending: sortByPersonCountDescending, leastPeopleSort: sortByPersonCountAscending, countSortDescriptor: selectCountDescriptor.returnText)
        allTitles[selectedYear.rawValue] = request.map(TitleViewModel.init)
        
    }
    
}
