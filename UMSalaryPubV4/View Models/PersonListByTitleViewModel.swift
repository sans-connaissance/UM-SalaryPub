//
//  PersonByTitleListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 12/6/21.
//

import CoreData
import Foundation


class PersonListByTitleViewModel: ObservableObject {
    @Published var personsByTitle = [PersonViewModel]()
    
    @Published var sortButtons = [SortOption: Bool]()
    
    private var namePredicate: NamePredicate = .Person
    private var moneyDescriptor: MoneySortDescriptor = .Person
    private var countDescriptor: CountSortDescriptor = .Person
    
    
    
    func setButtons() {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[SortOption.sortByMoneyDescending] = true
    }
    
}
