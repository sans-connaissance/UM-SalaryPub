//
//  DepartmentDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class DepartmentDetailViewModel: ObservableObject {
    
    @Published var departmentsDetail = [DepartmentViewModel]()
    private var selectedKeyPath: NamePredicate = .Department
    
    func getDepartments(vm: DepartmentViewModel) {
        let request: [Department] = Department.byName(keyPath: selectedKeyPath.returnText, name: vm.departmentName)
        departmentsDetail = request.map(DepartmentViewModel.init)
        
    }
}
