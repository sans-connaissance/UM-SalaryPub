//
//  PersonListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/10/21.
//

import SwiftUI

struct PersonListView: View {
    
    let personList: [PersonViewModel]
    
    
    var body: some View {
        List {
            ForEach(personList, id: \.self) { person in
                PersonRow(person: person)
                
            }
        }
    }
}


