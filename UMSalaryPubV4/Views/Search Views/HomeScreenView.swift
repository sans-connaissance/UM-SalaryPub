//
//  HomeScreen.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack {
            List {
                Section(header: VStack {
                    Text("Search UM SalaryPub")})
                {
                    NavigationLink(
                        destination: PersonListView())
                    {Text("People").font(.headline)}
                    .isDetailLink(false)
                    .padding(.top)
                    .padding(.bottom)
                    NavigationLink(
                        destination: TitleListView())
                    {Text("Titles").font(.headline)}
                    .isDetailLink(false)
                    .padding(.top)
                    .padding(.bottom)
                    NavigationLink(
                        destination: DepartmentListView())
                    {Text("Departments").font(.headline)}
                    .isDetailLink(false)
                    .padding(.top)
                    .padding(.bottom)
                    NavigationLink(
                        destination: CampusListView())
                    {Text("Campuses").font(.headline)}
                    .isDetailLink(false)
                    .padding(.top)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Home")
            .padding(.bottom)
            .listStyle(GroupedListStyle())
        }.embedInNavigationView()
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
