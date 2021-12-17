//
//  TitleDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation
import SwiftUI

class TitleDetailViewModel: ObservableObject {
    @Published var titlesDetail = [TitleViewModel]()
    
    private var nameKP: NamePredicate = .Title
    private var yearKP: YearByType = .Title
    
    func getTitles(vm: TitleViewModel) {
        let request: [Title] = Title.byName(keyPath: nameKP.returnText, name: vm.titleName)
        titlesDetail = request.map(TitleViewModel.init)
    }
    
    func campusesWithTitle(vm: TitleViewModel) -> [String] {
        var campusArray: [String] = []
        var personsArray: [Person] = []
        let titlesArray: [Title] = Title.campusesWithTitleOrDepartment(nameKeyPath: nameKP.returnText, yearKeyPath: yearKP.returnText, name: vm.titleName, year: vm.year)
        personsArray = titlesArray[0].personsWithTitle
        for campus in personsArray {
            if let campusName = campus.campus?.campusName {
                campusArray.append(campusName)
            }
        }
        let uniqueCampusArray = Array(Set(campusArray)).sorted()
        return uniqueCampusArray
    }
}
