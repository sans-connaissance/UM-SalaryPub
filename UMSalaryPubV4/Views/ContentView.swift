//
//  ContentView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            //MARK: Uncomment below to enable admin view for importing new data from JSON
//            DataDashboardView()
//                .tabItem {
//                    Image(systemName: "wrench.and.screwdriver")
//                    Text(verbatim: "Admin")
//                }.tag(0)
            HomeScreenView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text(verbatim: "Search")
                }.tag(1)

            MoreInfoView()
                .tabItem {
                    Image(systemName: "info")
                    Text(verbatim: "More Info")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
