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

                    }
                }
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
