//
//  ContentView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import SwiftUI

struct ContentView: View {
    
    //@StateObject private var adminVM = AdminViewModel()
    
    
    // Create the Tab views so that Admin // Main // and Other stuff is there
    
    var body: some View {
        
        TabView {
            TwentyDataDashBoardView()
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver")
                    Text(verbatim: "Admin")
                }.tag(0)
            
            HomeScreenView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text(verbatim: "Search")
                }.tag(1)
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star")
                    Text(verbatim: "Favorites")
                }.tag(2)
            
            MoreInfoView()
                .tabItem {
                    Image(systemName: "info")
                    Text(verbatim: "More Info")
                }.tag(3)
        }
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



