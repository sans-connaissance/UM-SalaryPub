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
                
                Picker("Select year", selection: $personListVM.selectedSortYear) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                        
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
            .onAppear(perform: personListVM.getPersonsByYear)
            
            
        }
    }
    
    var alphabetSortButton: some View {
        Button {
            personListVM.alphabetSort.toggle()
            personListVM.getPersonsByYear()
            
        } label: {
            Text("abc")
                .foregroundColor(personListVM.alphabetSort ? .blue : .gray)
        }
    }
    
    var mostMoneySortButton: some View {
        Button {
            personListVM.moneySort = true
            personListVM.getPersonsByYear()
        } label: {
            Text("$$$")
                .foregroundColor(personListVM.moneySort ? .blue : .gray)
        }
    }
    
    var leastMoneySortButton: some View {
        Button {
            personListVM.moneySort = false
            personListVM.getPersonsByYear()
        } label: {
            Text("$$$")
                .foregroundColor(personListVM.moneySort ? .gray : .blue)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
