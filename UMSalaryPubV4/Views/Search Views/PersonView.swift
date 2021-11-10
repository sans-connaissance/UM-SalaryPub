//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonView: View {
    
    @StateObject private var personListVM = PersonListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                year20
                year19
                
            }
//            Picker("Select Year", selection: $personListVM.selectedSortYear) {
//                ForEach(SortYear.allCases, id: \.self) {
//                    Text($0.displayText)
//
//                }
//            }
            
            Divider()
            List {
                ForEach(personListVM.persons, id: \.self) { person in
                    PersonRow(person: person)
                    
                    
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: personListVM.getAllByYear)
        }
    }
    
    var year20: some View {
        Button {
            personListVM.selectedSortYear = SortYear.twenty
            personListVM.sortByYear()
        } label: {
            Text("2020")
        }
    }
    
    var year19: some View {
        Button {
            personListVM.selectedSortYear = SortYear.nineteen
            personListVM.sortByYear()
        } label: {
            Text("2020")
        }
    }
    
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
