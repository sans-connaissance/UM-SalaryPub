//
//  ContentView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
        VStack {
            loadButton
            TwentyDataDashBoardView()

        }.padding()

    }

    
}


var loadButton: some View {
    Button {
        PersonDAO.shared.addPersonsIfNeeded()
    } label: {
        Text("Load Data")
    }
    
}



struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
        
    }
}



