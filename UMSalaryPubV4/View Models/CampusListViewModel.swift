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
    @Published var firstAppear = true
    ///Year needs to be updated when a new year is added.
    @Published var year: FetchYear = .twentyOne
    @Published var purchased = false
    @Published var presentBuyAlert = false
    @Published var searchText = " "
    @Published var uuid = UUID()
    
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
    /// Sets initial state of the sort buttons for the ListView.
    /// If firstAppear = false, then the user selected sortbutton selection on the ListView is saved until the home button is pressed or until the user navigates back to the homescreen.
    func setButtons(check: AppState.YearPurchased) {
        if firstAppear {
            SortOption.allCases.forEach { button in
                sortButtons[button] = false
            }
            sortButtons[SortOption.sortByPersonCountDescending] = true
            purchased(check: check)
        }
    }
    /// This function is called when the ListView disappears.
    /// It is used to ensure that the ListView search and sort options are not reset while a user is navigating to and from detailViews.
    func flipFirstAppear() {
        firstAppear = false
    }
    /// UUID for ScrollView is required to fix ScrollView bug detailed here:
    ///https://stackoverflow.com/questions/69697944/swiftui-picker-problem-after-dismissing-fullscreencover-or-sheet
    func createUUID() {
        uuid = UUID()
    }
    
    func purchased(check: AppState.YearPurchased) {
        switch check {
        case .none:
            purchased = false
            presentBuyAlert = true
            year = .twentyOne
        case .twentyTwo:
            purchased = true
            presentBuyAlert = false
            year = .twentyTwo
        }
    }
}
