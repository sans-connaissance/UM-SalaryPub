//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonListView: View {
    @StateObject private var vm = PersonListViewModel()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(.red)
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getPersons() }
            
            HStack {
                Picker("Select year", selection: $vm.year) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }.onChange(of: vm.year) { _ in vm.getPersons() }
                
                ForEach(SortOption.personList, id: \.self) { button in
                    SortListButton(selected: button, sortButtons: $vm.sortButtons)
                        .onChange(of: vm.sortButtons) { _ in vm.getPersons() }
                }
            }
            Divider()
            List {
                if let personarray = vm.allPersons[vm.year.rawValue] {
                    ForEach(personarray, id: \.self) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            PersonRow(person: person)
                        }.isDetailLink(true)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: { vm.setButtons() })
            .onAppear(perform: { vm.getPersons() })
            
        }.navigationTitle("People")
    }
}

struct PersonRow: View {
    let person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(person.fullName).font(.headline)
            Text(person.title).textStyle(DetailData())
            Text(person.apptAnnualFTR).textStyle(DetailData())
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView()
    }
}
