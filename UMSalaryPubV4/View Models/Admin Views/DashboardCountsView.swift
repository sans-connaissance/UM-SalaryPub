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
            Text("Person Count: \(adminVM.personsAll.count)")

            
            
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
