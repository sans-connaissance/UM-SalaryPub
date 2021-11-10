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
                year20
                year19
                
            }
            Divider()
            List {
                ForEach(personListVM.importYears, id: \.self) { year in
                    
                    ForEach(personListVM.allPersons[year]!, id: \.self) { person in
                        PersonRow(person: person)
                        
                    }
                    
                    
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: personListVM.getAllByYear)
        }
    }
    
    var year20: some View {
        Button {
            personListVM.selectedSortYear = SortYear.twenty
           
        } label: {
            Text("2020")
        }
    }
    
    var year19: some View {
        Button {
            personListVM.selectedSortYear = SortYear.nineteen
          
        } label: {
            Text("2020")
        }
    }
    
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
