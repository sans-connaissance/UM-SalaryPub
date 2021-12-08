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
    private var selectedKeyPath: NamePredicate = .Title

    func getTitles(vm: TitleViewModel) {
        let request: [Title] = Title.byName(keyPath: selectedKeyPath.returnText, name: vm.titleName)
        titlesDetail = request.map(TitleViewModel.init)
    }

    func titlesOnCampus(vm: TitleViewModel) -> [String] {
        var campusArray: [String] = []
        var personsArray: [Person] = []
        let request: [Title] = Title.byName(keyPath: selectedKeyPath.returnText, name: vm.titleName)
        let titleTest = request.first

        personsArray = titleTest!.personsWithTitle
        for campus in personsArray {
            campusArray.append((campus.campus?.campusName!)!)
        }

        let uniqueTitleArray = Array(Set(campusArray)).sorted()
        return uniqueTitleArray
    }
}
