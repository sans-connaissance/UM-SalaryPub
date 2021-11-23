//
//  CampusDetailViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Foundation

class CampusDetailViewModel: ObservableObject {
    
    @Published var campusesDetail = [CampusViewModel]()
    private var selectedKeyPath: NamePredicate = .Campus
    
    func getCampuses(vm: CampusViewModel) {
        let request: [Campus] = Campus.byName(keyPath: selectedKeyPath.returnText, name: vm.campusName)
        campusesDetail = request.map(CampusViewModel.init)
        
    }
}
