//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import CoreData
import Foundation
import UIKit

class PersonListViewModel: ObservableObject {
    @Published var allPersons = [Int: [PersonViewModel]]()
    @Published var sortButtons = [SortOption: Bool]()
    @Published var firstAppear = true
    @Published var searchText = " "
    ///Year needs to be updated when a new year is added.
    @Published var year: FetchYear = .twentyOne
    @Published var uuid = UUID()
    
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
            sortAlphabetically: sortButtons[SortOption.sortAlphabetically] ?? false,
            sortByMoneyDescending: sortButtons[SortOption.sortByMoneyDescending] ?? false,
            sortByMoneyAscending: sortButtons[SortOption.sortByMoneyAscending] ?? false,
            sortByPersonCountDescending: sortButtons[SortOption.sortByPersonCountDescending] ?? false,
            sortByPersonCountAscending: sortButtons[SortOption.sortByPersonCountAscending] ?? false,
            moneySortDescriptor: moneyDescriptor.returnText,
            countSortDescriptor: countDescriptor.returnText)
        
        allPersons[year.rawValue] = request.map(PersonViewModel.init)
    }
    /// Sets initial state of the sort buttons for the ListView.
    /// If firstAppear = false, then the user selected sortbutton selection on the ListView is saved until the home button is pressed or until the user navigates back to the homescreen.
    func setButtons() {
        if firstAppear {
            SortOption.allCases.forEach { button in
                sortButtons[button] = false
            }
            sortButtons[SortOption.sortByMoneyDescending] = true
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
}
