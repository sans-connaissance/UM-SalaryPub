//
//  PersonView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import SwiftUI

struct PersonView: View {
    
    @StateObject private var personListVM = PersonListViewModel()
    @State var searchText = " "
    
    var body: some View {
        VStack {
            //work on search bar next
            SearchBarView(searchText: $searchText)
//                .onReceive(Publisher, perform: T##(Publisher.Output) -> Void)

            HStack {
                
                Picker("Select year", selection: $personListVM.selectedSortYear) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
              
                mostMoneySortButton
                leastMoneySortButton
                alphabetSortButton
            }
            Divider()
            List {
                
                if let personarray = personListVM.allPersons[personListVM.selectedSortYear.rawValue] {
                    ForEach(personarray, id: \.self) { person in
                        PersonRow(person: person)
                        
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: { personListVM.getPersonsByYear(filter: searchText)
            })
        }
    }
    var alphabetSortButton: some View {
        Button {
            personListVM.mostMoneySort = false
            personListVM.leastMoneySort = false
            personListVM.alphabetSort = true
            personListVM.getPersonsByYear(filter: searchText)
            
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
            personListVM.getPersonsByYear(filter: searchText)
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
            personListVM.getPersonsByYear(filter: searchText)
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



//                Picker("Money Filter", selection: $personListVM.moneySort) {
//                    ForEach(MoneySort.allCases, id: \.self) {
//                        Text($0.displayText)
//                    }
//                }
//                .onChange(of: personListVM.moneySort) { _ in personListVM.getPersonsByYear()
//                    personListVM.alphabetSort = false
//                }
//                .accentColor(personListVM.alphabetSort ? .gray : .blue)
