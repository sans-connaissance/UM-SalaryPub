//
//  CampusListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/18/21.
//

import CoreData
import Foundation

class CampusListViewModel: ObservableObject {
    @Published var allCampuses = [Int: [CampusViewModel]]()
    
    @Published var sortButtons = [SortOption: Bool]()
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "

    private var yearByType: YearByType = .Campus
    private var importYears = Campus.importYears
    private var namePredicate: NamePredicate = .Campus
    private var moneyDescriptor: MoneySortDescriptor = .Campus
    private var countDescriptor: CountSortDescriptor = .Campus

    func getCampuses() {
        let request: [Campus] = Campus.search(
            byYear: String(year.rawValue),
            byType: yearByType.returnText,
            bySearchText: searchText,
            byNamePredicate: namePredicate.returnText,
            sortAlphabetically: sortButtons[SortOption.sortAlphabetically] ?? false,
            sortByMoneyDescending: sortButtons[SortOption.sortByMoneyDescending] ?? false,
            sortByMoneyAscending: sortButtons[SortOption.sortByMoneyAscending] ?? false,
            sortByPersonCountDescending: sortButtons[SortOption.sortByPersonCountDescending] ?? false,
            sortByPersonCountAscending: sortButtons[SortOption.sortByPersonCountAscending] ?? false,
            moneySortDescriptor: moneyDescriptor.returnText,
            countSortDescriptor: countDescriptor.returnText)
        
        allCampuses[year.rawValue] = request.map(CampusViewModel.init)
    }
    
    func setButtons() {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[SortOption.sortByPersonCountDescending] = true
    }
}
