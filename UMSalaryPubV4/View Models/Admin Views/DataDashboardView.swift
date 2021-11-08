//
//  DataDashBoardView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct DataDashboardView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
        
        VStack {
            
            loadButton
            DashboardCountsView()
            
        }
    }
    
    
    
    var loadButton: some View {
        Button {
            PersonDAO.shared.addPersonsIfNeeded(fileDate: 2020)

        } label: {
            Text("Load Data")
        }
    }
    
}

struct DataDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DataDashboardView()
    }
}
