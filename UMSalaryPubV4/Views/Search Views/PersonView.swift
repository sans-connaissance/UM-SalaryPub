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
        List {
            ForEach(personListVM.persons, id: \.self) { person in
                PersonRow(person: person)
                
                
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: personListVM.getAllPersons)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
