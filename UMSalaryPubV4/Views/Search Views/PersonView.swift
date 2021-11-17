//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonView: View {
    
    @StateObject private var personListVM = ListViewModel(selectedNamePredicate: NamePredicateOrSort.Person, selectMoneyDescriptor: MoneySortDescriptor.Person, selectCountDescriptor: CountSortDescriptor.Person)
    
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

                mostMoneySortButton
                leastMoneySortButton
                alphabetSortButton
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
    var alphabetSortButton: some View {
        Button {
            personListVM.mostMoneySort = false
            personListVM.leastMoneySort = false
            personListVM.alphabetSort = true
            personListVM.personSearch()
            
        } label: {
            Text("abc")
                .foregroundColor(personListVM.alphabetSort ? .blue : .gray)
        }
    }
    
    var mostMoneySortButton: some View {
        Button {
            personListVM.mostMoneySort = true
            personListVM.leastMoneySort = false
            personListVM.alphabetSort = false
            personListVM.personSearch()
        } label: {
            Text("$$$")
                .foregroundColor(personListVM.mostMoneySort ? .blue : .gray)
        }
    }
    
    var leastMoneySortButton: some View {
        Button {
            personListVM.mostMoneySort = false
            personListVM.leastMoneySort = true
            personListVM.alphabetSort = false
            personListVM.personSearch()
        } label: {
            Text("$")
                .foregroundColor(personListVM.leastMoneySort ? .blue : .gray)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
