//
//  HomeScreen.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/24/21.

import SwiftUI
import StoreKit

struct HomeScreenView: View {
    @StateObject private var vm = PersonListViewModel()
    @StateObject private var store = StoreKitManager()
    
    @State private var purchasePressed = true
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Search UM SalaryPub")) {
                        NavigationLink(
                            destination: PersonListView())
                        { Text("People").font(.headline)
                                .accessibilityIdentifier("homeScreenPeopleButton")
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)
                        NavigationLink(
                            destination: TitleListView())
                        { Text("Titles").font(.headline)
                                .accessibilityIdentifier("homeScreenTitlesButton")
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)
                        NavigationLink(
                            destination: DepartmentListView())
                        { Text("Departments").font(.headline)
                                .accessibilityIdentifier("homeScreenDepartmentsButton")
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)
                        NavigationLink(
                            destination: CampusListView())
                        { Text("Campuses").font(.headline)
                                .accessibilityIdentifier("homeScreenCampusesButton")
                        }
                        .isDetailLink(false)
                        .padding(.top)
                        .padding(.bottom)
                    }
                        Section(header: Text("Available Salary Data")) {
                        ForEach(store.storeProducts) { product in
                            HStack(alignment: .bottom) {
                                Button {
                                    Task { try await store.purchase(product) }
                                } label: {
                                    YearItem(storeKit: store, product: product)
                                }
                                .buttonStyle(.borderedProminent)
                                Text(product.displayName)
                            }
                        }
                        ForEach(vm.years, id: \.self) { year in
                            OldYearItem(year: year)
                        }
                    }
                }
                .navigationTitle("Home")
                .padding(.bottom)
                .listStyle(GroupedListStyle())
            }
            ///Default PersonDetailView for iPad
            if let person = vm.allPersons[vm.year.rawValue] {
                PersonDetailView(person: person.randomElement() ?? person[0], purchased: vm.purchased)
            }
        }.onAppear(perform: { vm.getPersons() })
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
