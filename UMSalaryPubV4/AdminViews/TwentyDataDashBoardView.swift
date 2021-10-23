//
//  TwentyDataDashBoardView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 1/24/21.
//

import SwiftUI
import CoreData

struct TwentyDataDashBoardView: View {
    
    let personsTwentyRequest = Person.twentyTwentyPersons()
    var personsTwenty: FetchedResults<Person> {
        personsTwentyRequest.wrappedValue
    }
    
    let titlesTwentyRequest = Title.twentyTwentyTitles()
    var twentyTitles: FetchedResults<Title> {
        titlesTwentyRequest.wrappedValue
    }
    
    let campusesTwentyRequest = Campus.twentyTwentyCampuses()
    var twentyCampuses: FetchedResults<Campus>{
        campusesTwentyRequest.wrappedValue
    }
    
    let departmentsTwentyRequest = Department.twentyTwentyDepartments()
    var twentyDepartments: FetchedResults<Department>{
        departmentsTwentyRequest.wrappedValue
    }
    
    var body: some View {
        
        List {
            Section(header: Text("2020")) {
                VStack(alignment:.leading) {
                    HStack {
                        Text("Persons Total:")
                        Spacer()
                        Text("\(personsTwenty.count)")
                    }
                    HStack {
                        Text("Titles Total:")
                        Spacer()
                        Text("\(twentyTitles.count)")
                    }
                    HStack {
                        Text("Departments Total:")
                        Spacer()
                        Text("\(twentyDepartments.count)")
                    }
                    HStack {
                        Text("Campuses Total:")
                        Spacer()
                        Text("\(twentyCampuses.count)")
                    }
                    
                }
            }
            
        }.listStyle(GroupedListStyle())
        
    }
}
