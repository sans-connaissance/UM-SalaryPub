//
//  DataDashBoardView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct DataDashBoardView: View {
    
    
    var body: some View {
        
        VStack {
            
            
        }
    }
    
    var loadButton: some View {
        Button {
            PersonDAO.shared.addPersonsIfNeeded()
        } label: {
            Text("Load Data")
        }
    }
}

struct DataDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DataDashBoardView()
    }
}
