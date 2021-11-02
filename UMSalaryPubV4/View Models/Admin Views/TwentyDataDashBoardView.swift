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
            Text("Person Count: \(adminVM.personsAll.count)")

            
            
        }
        .onAppear(perform: {
            adminVM.loadAdminScreen()
        })
        
    }
    
}


