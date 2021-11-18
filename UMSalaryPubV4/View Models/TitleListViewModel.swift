//
//  TitleListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import Foundation
import CoreData

class TitleListViewModel: ObservableObject {
    
    @Published var importYears = Title.importYears
    
    @Published var allTitles = [Int: [TitleViewModel]]()
    
    @Published var searchText = " "
    @Published var selectedYear: FetchYear = .twenty
    
    //these probably can be private vars in all cases
    @Published var selectedNamePredicate: NamePredicateOrSort = .Title
    @Published var selectMoneyDescriptor: MoneySortDescriptor = .Title
    @Published var selectCountDescriptor: CountSortDescriptor = .Title
    @Published var selectYearByType: YearByType = .Title
    
    @Published var mostMoneySort = false
    @Published var leastMoneySort = false
    @Published var alphabetSort = false
    
    @Published var mostPeopleSort = true
    @Published var leastPeopleSort = false
    
    
    func titleSearch() {
        let request: [Title] = Title.search(yearPredicate: String(selectedYear.rawValue), yearByType: selectYearByType.returnText, filterPredicate: searchText, mostMoneySort: mostMoneySort, leastMoneySort: leastMoneySort, moneySortDescriptor: selectMoneyDescriptor.returnText, alphabetSort: alphabetSort, namePredicateOrSort: selectedNamePredicate.returnText, mostPeopleSort: mostPeopleSort, leastPeopleSort: leastPeopleSort, countSortDescriptor: selectCountDescriptor.returnText)
        allTitles[selectedYear.rawValue] = request.map(TitleViewModel.init)
        
    }
    
}
