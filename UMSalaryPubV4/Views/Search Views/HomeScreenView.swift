//
//  HomeScreen.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    Section(header: VStack {
                        Text("UM SalaryPub")
                    }
                    
                    ) {
                        NavigationLink {
                            PersonView()
                        } label: {
                            Text("People").font(.headline)
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)
                        
                        NavigationLink {
                            TitleView()
                        } label: {
                            Text("Titles").font(.headline)
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)

                    }
                }.navigationTitle("Home")
                    .listStyle(GroupedListStyle())
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
