//
//  Buttons.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI


struct SortAlphabeticallyButton: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = false
            sortAlphabetically = true
            sortByPersonCountDescending = false
            sortByPersonCountAscending = false
            
        } label: {
            Text("abc")
               .foregroundColor(sortAlphabetically ? .blue : .gray)
        }
        
    }
}


//
//var sortByMoneyDescendingButton: some View {
//    Button {
//        titleListVM.sortByMoneyDescending = true
//        titleListVM.sortByMoneyAscending = false
//        titleListVM.sortAlphabetically = false
//        titleListVM.titleSearch()
//    } label: {
//        Text("$$$")
//            .foregroundColor(titleListVM.sortByMoneyDescending ? .blue : .gray)
//    }
//}
//
//var sortByMoneyAscendingButton: some View {
//    Button {
//        titleListVM.sortByMoneyDescending = false
//        titleListVM.sortByMoneyAscending = true
//        titleListVM.sortAlphabetically = false
//        titleListVM.titleSearch()
//    } label: {
//        Text("$")
//            .foregroundColor(titleListVM.sortByMoneyAscending ? .blue : .gray)
//    }
//}
