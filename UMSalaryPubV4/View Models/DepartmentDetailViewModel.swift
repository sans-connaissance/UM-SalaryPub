//
//  DepartmentDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class DepartmentDetailViewModel: ObservableObject {
    @Published var departmentsDetail = [DepartmentViewModel]()
    private var nameKP: NamePredicate = .Department
    private var yearKP: YearByType = .Department

    func getDepartments(vm: DepartmentViewModel) {
        let request: [Department] = Department.byName(keyPath: nameKP.returnText, name: vm.departmentName)
        departmentsDetail = request.map(DepartmentViewModel.init)
    }
    
    func campusesWithDepartment(vm: DepartmentViewModel) -> [String] {
        var campusArray: [String] = []
        var personsArray: [Person] = []
        let departmentsArray: [Department] = Department.campusesWithTitleOrDepartment(nameKeyPath: nameKP.returnText, yearKeyPath: yearKP.returnText, name: vm.departmentName, year: vm.year)
        personsArray = departmentsArray[0].personsInDepartment
        for campus in personsArray {
            if let campusName = campus.campus?.campusName {
                campusArray.append(campusName)
            }
        }
        let uniqueCampusArray = Array(Set(campusArray)).sorted()
        return uniqueCampusArray
    }
}
