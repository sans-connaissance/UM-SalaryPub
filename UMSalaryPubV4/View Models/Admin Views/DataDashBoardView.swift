//
//  DataDashBoardView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct DataDashBoardView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
        
        VStack {
            
            loadButton
            TwentyDataDashBoardView()
            
        }
    }
    
    var loadButton: some View {
        Button {
            PersonDAO.shared.addPersonsIfNeeded()
            adminVM.getAllPersons()
            adminVM.getAllTitles()
        } label: {
            Text("Load Data")
        }
    }
    
//    var displayButton: some View {
//        Button {
//
//        } label: {
//            Text("Display em")
//        }
//
//    }
}

struct DataDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DataDashBoardView()
    }
}
