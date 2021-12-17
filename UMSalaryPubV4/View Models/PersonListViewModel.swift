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
    @Published var year: FetchYear = .twenty
    @Published var pickerID = UUID()
    
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
    
    func setButtons() {
        if firstAppear {
            SortOption.allCases.forEach { button in
                sortButtons[button] = false
            }
            sortButtons[SortOption.sortByMoneyDescending] = true
        }
    }
    
    func flipFirstAppear() {
        firstAppear = false
    }
    
    func createPickerID() {
        pickerID = UUID()
    }
}
