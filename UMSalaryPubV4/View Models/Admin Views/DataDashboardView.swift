//
//  DataDashBoardView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct DataDashboardView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    @State private var selectedYear = 2020
    
    
    var importYears = [2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013]
    
    var body: some View {
        
        VStack {
            
            loadButton
            Picker("Select year to import", selection: $selectedYear) {
                ForEach(importYears, id: \.self) {
                    Text(String($0))
                }
            }
            Divider()
            DashboardCountsView()
            
        }
    }
    
    
    
    var loadButton: some View {
        Button {
            PersonDAO.shared.addPersonsIfNeeded(importYear: selectedYear)
            
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

