//
//  TwentyDataDashBoardView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 1/24/21.
//

import SwiftUI
import CoreData

struct TwentyDataDashBoardView: View {
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
        
        VStack {
            displayButton
            
            List {
                ForEach(adminVM.persons, id: \.id) { person in
                    PersonCell(person: person)
                    
                }
                
            }.listStyle(GroupedListStyle())
                .embedInNavigationView()
            
        }
    }
    var displayButton: some View {
        Button {
            adminVM.getAllPersons()
        } label: {
            Text("Display em")
        }
        
    }
}

struct PersonCell: View {
    
    let person: PersonViewModel
    
    var body: some View {
        VStack {
            Text(person.fullName)
        }
        
    }
    
}
