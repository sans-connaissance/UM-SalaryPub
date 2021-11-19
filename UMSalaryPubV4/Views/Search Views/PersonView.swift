//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonView: View {
    
    @StateObject private var vm = PersonListViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.personSearch()}
            
            HStack {
                Picker("Select year", selection: $vm.year) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: vm.year) { _ in vm.personSearch()}
                
                SortByMoneyDescendingButton(
                    sortByMoneyDescending: $vm.sortByMoneyDescending,
                    sortByMoneyAscending: $vm.sortByMoneyAscending,
                    sortAlphabetically: $vm.sortAlphabetically,
                    sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                    sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                    .onChange(of: vm.sortByMoneyDescending){ _ in vm.personSearch()}
                
                SortByMoneyAscendingButton(
                    sortByMoneyDescending: $vm.sortByMoneyDescending,
                    sortByMoneyAscending: $vm.sortByMoneyAscending,
                    sortAlphabetically: $vm.sortAlphabetically,
                    sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                    sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                    .onChange(of: vm.sortByMoneyAscending){ _ in vm.personSearch()}
                
                SortAlphabeticallyButton(
                    sortByMoneyDescending: $vm.sortByMoneyDescending,
                    sortByMoneyAscending: $vm.sortByMoneyAscending,
                    sortAlphabetically: $vm.sortAlphabetically,
                    sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                    sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                    .onChange(of: vm.sortAlphabetically){ _ in vm.personSearch()}
            }
            Divider()
            List {
                
                if let personarray = vm.allPersons[vm.year.rawValue] {
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
            .onAppear(perform: { vm.personSearch()})
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
