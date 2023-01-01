//
//  PersonByTitleListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 12/6/21.
//

import Foundation

class PersonListByTitleViewModel: ObservableObject {
    @Published var personsByTitle = [PersonViewModel]()
    @Published var sortButtons = [SortOption: Bool]()
    @Published var firstAppear = true
    @Published var purchased = false
    
    func getPersonsByTitle(vm: TitleViewModel) {
        let request: [Person] = Person.byTitle(
            year: String(vm.title.titleYear),
            titleName: vm.titleName,
            sortByMoneyDescending: sortButtons[SortOption.sortByMoneyDescending] ?? false,
            sortByMoneyAscending: sortButtons[SortOption.sortByMoneyAscending] ?? false,
            sortAlphabetically: sortButtons[SortOption.sortAlphabetically] ?? false)
        
        personsByTitle = request.map(PersonViewModel.init)
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
    
    func purchased(check: AppState.YearPurchased) {
        switch check {
        case .none:
            purchased = false
        case .twentyTwo:
            purchased = true
        }
    }
}
