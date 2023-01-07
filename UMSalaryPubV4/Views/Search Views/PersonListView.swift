//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI
import StoreKit

struct PersonListView: View {
    @StateObject private var vm = PersonListViewModel()
    @StateObject private var store = StoreKitManager()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getPersons() }
                .onTapGesture {
                    ///Initial " " space string is needed for fetch request, but needs to be removed when user taps searchbar in order to search
                    if vm.searchText == " " {
                        vm.searchText = ""
                    }
                }
            ///Sort options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    Picker("Select Year", selection: $vm.year) {
                        switch vm.purchased {
                        case true:
                            ForEach(FetchYear.allCases, id: \.self) {
                                Text($0.displayText)
                            }
                        case false:
                            ForEach(FetchYear.allCases.dropFirst(), id: \.self) {
                                Text($0.displayText)
                            }
                        }
                    }
                    .id(vm.uuid)
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .onChange(of: vm.year) { _ in vm.getPersons() }
                    Text("|").font(.callout).foregroundColor(.secondary)
                    ForEach(SortOption.personList, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getPersons() }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
            }.padding([.leading, .trailing])
            Divider()
            ///Main List View
            List {
                if let personarray = vm.allPersons[vm.year.rawValue] {
                    ForEach(personarray, id: \.self) { person in
                        NavigationLink {
                            PersonDetailView(person: person, purchased: vm.purchased)
                        } label: {
                            PersonRow(person: person)
                        }
                        .isDetailLink(true)
                        .listRowBackground(Color(UIColor.systemBackground))
                    }
                }
            }
            .accessibilityIdentifier("personListView")
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("People")
        .padding(.bottom)
        .alert(isPresented: $vm.presentBuyAlert) {
            Alert(
                title: Text("2022 U of M Salary Data is available to load for $1.99 on the Home Screen."),
                primaryButton: .default(Text("Home")) {
                    AppState.shared.viewID = UUID()
                },
                secondaryButton: .cancel())
        }
        .onChange(of: store.purchasedYears) { year in
            Task {
                    AppState.shared.purchased = .twentyTwo
            }
        }
        .onAppear(perform: { vm.getPersons() })
        .onAppear(perform: { vm.setButtons(check: AppState.shared.purchased) })
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
