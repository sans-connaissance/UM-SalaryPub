//
//  TitleDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class TitleDetailViewModel: ObservableObject {
    @Published var titlesDetail = [TitleViewModel]()
    private var selectedKeyPath: NamePredicate = .Title

    func getTitles(vm: TitleViewModel) {
        let request: [Title] = Title.byName(keyPath: selectedKeyPath.returnText, name: vm.titleName)
        titlesDetail = request.map(TitleViewModel.init)
    }
}
