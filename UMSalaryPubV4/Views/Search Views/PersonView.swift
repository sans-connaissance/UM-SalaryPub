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
                
                
                Picker("Money Filter", selection: $personListVM.moneySort) {
                    ForEach(MoneySort.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }.onChange(of: personListVM.moneySort) { _ in personListVM.getPersonsByYear()
                }
                
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
            if personListVM.alphabetSort {
                Text("abc")
            } else {
                Text("abc")
                    .foregroundColor(.gray)
            }
            
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
