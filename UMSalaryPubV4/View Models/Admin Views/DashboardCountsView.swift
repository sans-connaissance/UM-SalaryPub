//
//  DashboardCountsView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/2/21.
//

import CoreData
import SwiftUI


struct DashboardCountsView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
         
        List {
            ForEach(adminVM.importYears, id: \.self) { year in
                Section(header: Text(String(year))) {
                    
                    if let personCount = adminVM.allPersons[year] {
                        let count = personCount.count
                        Text("Person: \(count)")
                    }
                    
                    if let titleCount = adminVM.allTitles[year] {
                        let count = titleCount.count
                        Text("Title: \(count)")
                    }
                    
                    if let departmentCount = adminVM.allDepartments[year] {
                        let count = departmentCount.count
                        Text("Department: \(count)")
                    }
                    
                    if let campusCount = adminVM.allCampuses[year] {
                        let count = campusCount.count
                        Text("Campus: \(count)")
                    }
                }
            }
        }
        .onAppear(perform: {
            adminVM.loadAdminScreen()
        })
    }
}

struct DashboardCountsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCountsView()
    }
}
