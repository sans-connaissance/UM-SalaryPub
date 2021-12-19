//
//  HomeScreen.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject private var vm = PersonListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: VStack {
                        Text("Search UM SalaryPub")
                    }) {
                        NavigationLink(
                            destination: PersonListView())
                        { Text("People").font(.headline) }
                            .isDetailLink(false)
                            .padding(.top)
                            .padding(.bottom)
                        NavigationLink(
                            destination: TitleListView())
                        { Text("Titles").font(.headline) }
                            .isDetailLink(false)
                            .padding(.top)
                            .padding(.bottom)
                        NavigationLink(
                            destination: DepartmentListView())
                        { Text("Departments").font(.headline) }
                            .isDetailLink(false)
                            .padding(.top)
                            .padding(.bottom)
                        NavigationLink(
                            destination: CampusListView())
                        { Text("Campuses").font(.headline) }
                            .isDetailLink(false)
                            .padding(.top)
                            .padding(.bottom)
                    }
                }
                .navigationTitle("Home")
                .padding(.bottom)
                .listStyle(GroupedListStyle())
            }
                if let person = vm.allPersons[vm.year.rawValue] {
                PersonDetailView(person: person[0])
            }
        }.onAppear(perform: { vm.getPersons() })
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
