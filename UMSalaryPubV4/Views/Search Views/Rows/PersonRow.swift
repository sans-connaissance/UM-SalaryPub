//
//  PersonRow.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/11/21.
//

import SwiftUI

struct PersonRow: View {
    
    let person: PersonViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            Text(person.fullName).font(.headline)
            Text(String(person.year))
            Text(person.title).textStyle(DetailData())
            Text(person.apptAnnualFTR).textStyle(DetailData())
        }
    }
}
