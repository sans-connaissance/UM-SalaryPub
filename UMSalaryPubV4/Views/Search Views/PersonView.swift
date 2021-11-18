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
                Picker("Select year", selection: $vm.selectedYear) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: vm.selectedYear) { _ in vm.personSearch()}
                
                sortByMoneyDescendingButton
                sortByMoneyAscendingButton
                
                SortAlphabeticallyButton(
                    sortByMoneyDescending: $vm.sortByMoneyDescending,
                    sortByMoneyAscending: $vm.sortByMoneyAscending,
                    sortAlphabetically: $vm.sortAlphabetically,
                    sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                    sortByPersonCountAscending: $vm.sortByMoneyAscending)
                    .onChange(of: vm.sortAlphabetically){ _ in vm.personSearch()}
            }
            Divider()
            List {
                
                if let personarray = vm.allPersons[vm.selectedYear.rawValue] {
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
            .onAppear(perform: { vm.personSearch()
            })
        }
    }
    var sortAlphabeticallyButton: some View {
        Button {
            vm.sortByMoneyDescending = false
            vm.sortByMoneyAscending = false
            vm.sortAlphabetically = true
            vm.personSearch()
            
        } label: {
            Text("abc")
                .foregroundColor(vm.sortAlphabetically ? .blue : .gray)
        }
    }
    
    var sortByMoneyDescendingButton: some View {
        Button {
            vm.sortByMoneyDescending = true
            vm.sortByMoneyAscending = false
            vm.sortAlphabetically = false
            vm.personSearch()
        } label: {
            Text("$$$")
                .foregroundColor(vm.sortByMoneyDescending ? .blue : .gray)
        }
    }
    
    var sortByMoneyAscendingButton: some View {
        Button {
            vm.sortByMoneyDescending = false
            vm.sortByMoneyAscending = true
            vm.sortAlphabetically = false
            vm.personSearch()
        } label: {
            Text("$")
                .foregroundColor(vm.sortByMoneyAscending ? .blue : .gray)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
