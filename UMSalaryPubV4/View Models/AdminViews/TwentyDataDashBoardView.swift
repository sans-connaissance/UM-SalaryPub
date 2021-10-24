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
    
    //need to rebuild ContentView in order to more directly embed the loaded views.
    //like in the MovieScreen example
    
    // create a version where there is a list of the topLevel People, Title, Campus, etc...
    // then click that to see if .onAppear works as expected.
    
    
    
    var body: some View {
        
        VStack {
            displayButton
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
            .embedInNavigationView()
            
            
        }
        
    }
    var displayButton: some View {
        Button {
            adminVM.getAllPersons()
            adminVM.getAllTitles()
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
            Text(person.title)
            Text(person.salary)
        }
        
    }
    
}
