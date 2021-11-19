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
    
    @Published var year: FetchYear = .twenty
    @Published var searchText = " "
    @Published var sortByMoneyDescending = false
    @Published var sortByMoneyAscending = false
    @Published var sortAlphabetically = false
    @Published var sortByPersonCountDescending = true
    @Published var sortByPersonCountAscending = false
    
    private var yearByType: YearByType = .Department
    private var importYears = Department.importYears
    private var namePredicate: NamePredicate = .Department
    private var moneyDescriptor: MoneySortDescriptor = .Department
    private var countDescriptor: CountSortDescriptor = .Department
    
    
    func departmentSearch() {
        let request: [Department] = Department.search(
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
        
        allDepartments[year.rawValue] = request.map(DepartmentViewModel.init)
    }
}
