//
//  TitleListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import CoreData
import Foundation

class TitleListViewModel: ObservableObject {

    @Published var allTitles = [Int: [TitleViewModel]]()
    
    @Published var sortButtons = [SortOption : Bool]()
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "
//    @Published var sortByMoneyDescending = false
//    @Published var sortByMoneyAscending = false
//    @Published var sortAlphabetically = false
//    @Published var sortByPersonCountDescending = true
//    @Published var sortByPersonCountAscending = false
    
    private var yearByType: YearByType = .Title
    private var importYears = Title.importYears
    private var namePredicate: NamePredicate = .Title
    private var moneyDescriptor: MoneySortDescriptor = .Title
    private var countDescriptor: CountSortDescriptor = .Title
    
    
    func getTitles() {
        let request: [Title] = Title.search(
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
        
        allTitles[year.rawValue] = request.map(TitleViewModel.init)
    }
    
    func setButtons() {
        
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        
        sortButtons[SortOption.sortByPersonCountDescending] = true
    }
    
    func listBy(sortOption: SortOption) {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        
        sortButtons[sortOption] = true
    }
    
}
