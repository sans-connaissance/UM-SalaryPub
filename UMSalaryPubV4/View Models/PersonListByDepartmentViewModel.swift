//
//  PersonListByDepartmentViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 12/7/21.
//

import Foundation


class PersonListByDepartmentViewModel: ObservableObject {
    @Published var personsByTitle = [PersonViewModel]()
    @Published var sortButtons = [SortOption: Bool]()
    
    func getPersonsByDepartment(vm: DepartmentViewModel) {
        let request: [Person] = Person.byDepartment(
            year: String(vm.department.departmentYear),
            departmentName: vm.departmentName,
            sortByMoneyDescending: sortButtons[SortOption.sortByMoneyDescending] ?? false,
            sortByMoneyAscending: sortButtons[SortOption.sortByMoneyAscending] ?? false,
            sortAlphabetically: sortButtons[SortOption.sortAlphabetically] ?? false)
        
        personsByTitle = request.map(PersonViewModel.init)
    }
    
    func setButtons() {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[SortOption.sortByMoneyDescending] = true
    }
}