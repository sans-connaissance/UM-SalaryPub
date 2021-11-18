//
//  Buttons.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI


struct AlphabetSortButton: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var alphabetSort: Bool
    @Binding var mostPeopleSort: Bool
    @Binding var leastPeopleSort: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = false
            alphabetSort = true
            mostPeopleSort = false
            leastPeopleSort = false
            
        } label: {
            Text("abc")
               .foregroundColor(alphabetSort ? .blue : .gray)
        }
        
    }
}


//
//var sortByMoneyDescendingButton: some View {
//    Button {
//        titleListVM.sortByMoneyDescending = true
//        titleListVM.sortByMoneyAscending = false
//        titleListVM.alphabetSort = false
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
//        titleListVM.alphabetSort = false
//        titleListVM.titleSearch()
//    } label: {
//        Text("$")
//            .foregroundColor(titleListVM.sortByMoneyAscending ? .blue : .gray)
//    }
//}
