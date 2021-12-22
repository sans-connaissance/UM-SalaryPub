//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonListView: View {
    @StateObject private var vm = PersonListViewModel()
    
    static let accessibilityLabel: [SortOption: LocalizedStringKey] = [
        .sortAlphabetically: "sortAlphabetically",
        .sortByMoneyDescending: "sortByMoneyDescending",
        .sortByMoneyAscending: "sortByMoneyAscending",
        .sortByPersonCountDescending: "sortByPersonCountDescending",
        .sortByPersonCountAscending: "sortByPersonCountAscending",
    ]

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .accessibility(identifier: "searchText")
                .onChange(of: vm.searchText) { _ in vm.getPersons() }
                .onTapGesture {
                    if vm.searchText == " " {
                        vm.searchText = ""
                    }
                }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    Picker("Select Year", selection: $vm.year) {
                        ForEach(FetchYear.allCases, id: \.self) {
                            Text($0.displayText)
                        }
                    }
                    .id(vm.uuid)
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .onChange(of: vm.year) { _ in vm.getPersons() }
                    Text("|").font(.callout).foregroundColor(.secondary)
                    ForEach(SortOption.personList, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .accessibility(identifier: String("\(Self.accessibilityLabel[button]!)"))
                            .onChange(of: vm.sortButtons) { _ in vm.getPersons() }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
            }.padding([.leading, .trailing])
            Divider()
            List {
                if let personarray = vm.allPersons[vm.year.rawValue] {
                    ForEach(personarray, id: \.self) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            PersonRow(person: person)
                        }
                        .isDetailLink(true)
                        .listRowBackground(Color(UIColor.systemBackground))
                    }
                }
            }
            .accessibility(identifier: "personList")
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("People")
        .padding(.bottom)
        .onAppear(perform: { vm.getPersons() })
        .onAppear(perform: { vm.setButtons() })
        .onAppear(perform: { vm.createUUID() })
        .onDisappear(perform: { vm.flipFirstAppear() })
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
