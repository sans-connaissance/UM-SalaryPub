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
        
        VStack {
            Section(header: Text("2020")) {
                Text("Person Count: \(adminVM.persons2020.count)")
                Text("Title Count: \(adminVM.titles2020.count)")
                Text("Department Count: \(adminVM.departments2020.count)")
                Text("Campus Count: \(adminVM.campuses2020.count)")
                
                
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
