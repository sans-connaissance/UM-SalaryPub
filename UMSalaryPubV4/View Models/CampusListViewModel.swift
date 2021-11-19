//
//  CampusListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/18/21.
//

import Foundation
import CoreData

class CampusListViewModel: ObservableObject {
    
    @Published var allCampuses = [Int: [CampusViewModel]]()
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "
    @Published var sortByMoneyDescending = true
    @Published var sortByMoneyAscending = false
    @Published var sortAlphabetically = false
    @Published var sortByPersonCountDescending = false
    @Published var sortByPersonCountAscending = false
    
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
            sortAlphabetically: sortAlphabetically,
            sortByMoneyDescending: sortByMoneyDescending,
            sortByMoneyAscending: sortByMoneyAscending,
            sortByPersonCountDescending: sortByPersonCountDescending,
            sortByPersonCountAscending: sortByPersonCountAscending,
            moneySortDescriptor: moneyDescriptor.returnText,
            countSortDescriptor: countDescriptor.returnText)
        
        allCampuses[year.rawValue] = request.map(CampusViewModel.init)
        
    }
}
