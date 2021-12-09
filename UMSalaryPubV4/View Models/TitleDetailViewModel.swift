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
        
        let request: [Title] = Title.campusesWithTitle(nameKeyPath: nameKP.returnText, yearKeyPath: yearKP.returnText, name: vm.titleName, year: vm.year)
          
        let titleTest = request.first

        personsArray = titleTest!.personsWithTitle
        for campus in personsArray {
            campusArray.append((campus.campus?.campusName!)!)
        }

        let uniqueTitleArray = Array(Set(campusArray)).sorted()
        return uniqueTitleArray
    }
}
