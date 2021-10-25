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
            Text("Person Count: \(adminVM.personCount)")
            Text("Title Count: \(adminVM.titleCount)")
            List {
                ForEach(adminVM.persons, id: \.id) { person in
                    PersonCell(person: person)
                    
                }
                
            }
            .onAppear(perform: {
                adminVM.getAllPersons()
                adminVM.getAllTitles()
            })
            .listStyle(GroupedListStyle())
            
        }
        
    }

}

struct PersonCell: View {
    
    let person: PersonViewModel
    
    var body: some View {
        VStack {
            Text(person.fullName)
            Text(person.title)
            Text(person.salary)
        }
        
    }
    
}
