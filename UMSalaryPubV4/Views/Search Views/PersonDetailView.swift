//
//  PersonDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import SwiftUI

struct PersonDetailView: View {
    
    // this needs to be replaced with a PersonListVM or PersonDetailVM that has a FetchRequest by the Peron's name
    // will like need to populate person with a variable passed from the PersonView
    @StateObject private var personDetailVM = PersonDetailViewModel()
    
    let person: PersonViewModel
    
    var body: some View {
        
        List{
            ForEach(personDetailVM.personsDetail.reversed(), id: \.self) { person in
                VStack {
                    Text(person.fullName)
                    Text(String(person.year))
                    Text(person.apptAnnualFTR)
                    
                }
            }
            
        } .onAppear(perform: { personDetailVM.getPersons(vm: person)
        })
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: PersonViewModel(person: Person(context: CoreDataManager.shared.viewContext)))
    }
}
