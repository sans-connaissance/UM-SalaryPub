//
//  DepartmentListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/18/21.
//
import CoreData
import Foundation

class DepartmentListViewModel: ObservableObject {

    @Published var allDepartments = [Int: [DepartmentViewModel]]()
    
    @Published var sortButtons = [SortOption : Bool]()
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "

    
    private var yearByType: YearByType = .Department
    private var importYears = Department.importYears
    private var namePredicate: NamePredicate = .Department
    private var moneyDescriptor: MoneySortDescriptor = .Department
    private var countDescriptor: CountSortDescriptor = .Department
    
    
    func getDepartments() {
        let request: [Department] = Department.search(
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
        
        allDepartments[year.rawValue] = request.map(DepartmentViewModel.init)
    }
    //Can this be refactored so that we're only defining set buttons in one location?
    //kind of cool that we can set whatever button we want for each viewlist though
    //could be put in baseclass maybe?
    func setButtons() {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[SortOption.sortByPersonCountDescending] = true
    }
}
