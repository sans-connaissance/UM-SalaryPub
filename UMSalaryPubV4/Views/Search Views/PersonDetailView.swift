//
//  PersonDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import SwiftUI

struct PersonDetailView: View {
    
    let person: PersonViewModel
    
    var body: some View {
        VStack {
            Text(person.fullName)
            Text(person.apptAnnualFTR)
            
        }
        
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: PersonViewModel(person: Person(context: CoreDataManager.shared.viewContext)))
    }
}
