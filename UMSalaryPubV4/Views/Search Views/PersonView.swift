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
            SearchBarView(searchText: $personListVM.searchText)
                .onChange(of: personListVM.searchText) { _ in personListVM.personSearch()}
            
            HStack {
                Picker("Select year", selection: $personListVM.selectedYear) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: personListVM.selectedYear) { _ in personListVM.personSearch()}
                
                sortByMoneyDescendingButton
                sortByMoneyAscendingButton
                
                
                //Alright lets create the other buttons and get moving
                SortAlphabeticallyButton(sortByMoneyDescending: $personListVM.sortByMoneyDescending, sortByMoneyAscending: $personListVM.sortByMoneyAscending, sortAlphabetically: $personListVM.sortAlphabetically, sortByPersonCountDescending: $personListVM.sortByPersonCountDescending, sortByPersonCountAscending: $personListVM.sortByMoneyAscending)
                    .onChange(of: personListVM.sortAlphabetically){ _ in
                        personListVM.personSearch()
                    }
            }
            Divider()
            List {
                
                if let personarray = personListVM.allPersons[personListVM.selectedYear.rawValue] {
                    ForEach(personarray, id: \.self) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            PersonRow(person: person)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("People")
            .onAppear(perform: { personListVM.personSearch()
            })
        }
    }
    var sortAlphabeticallyButton: some View {
        Button {
            personListVM.sortByMoneyDescending = false
            personListVM.sortByMoneyAscending = false
            personListVM.sortAlphabetically = true
            personListVM.personSearch()
            
        } label: {
            Text("abc")
                .foregroundColor(personListVM.sortAlphabetically ? .blue : .gray)
        }
    }
    
    var sortByMoneyDescendingButton: some View {
        Button {
            personListVM.sortByMoneyDescending = true
            personListVM.sortByMoneyAscending = false
            personListVM.sortAlphabetically = false
            personListVM.personSearch()
        } label: {
            Text("$$$")
                .foregroundColor(personListVM.sortByMoneyDescending ? .blue : .gray)
        }
    }
    
    var sortByMoneyAscendingButton: some View {
        Button {
            personListVM.sortByMoneyDescending = false
            personListVM.sortByMoneyAscending = true
            personListVM.sortAlphabetically = false
            personListVM.personSearch()
        } label: {
            Text("$")
                .foregroundColor(personListVM.sortByMoneyAscending ? .blue : .gray)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
