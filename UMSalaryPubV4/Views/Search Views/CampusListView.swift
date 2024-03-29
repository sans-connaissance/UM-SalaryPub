//
//  CampusListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct CampusListView: View {
    @StateObject private var vm = CampusListViewModel()
    @StateObject private var store = StoreKitManager()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getCampuses() }
                .onTapGesture {
                    ///Initial " " space string is needed for fetch request, but needs to be removed when user taps searchbar in order to search
                    if vm.searchText == " " {
                        vm.searchText = ""
                    }
                }
            ///Sort options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    Picker("Select Year", selection: $vm.year) {
                        switch vm.purchased {
                        case true:
                            ForEach(FetchYear.allCases, id: \.self) {
                                Text($0.displayText)
                            }
                        case false:
                            ForEach(FetchYear.allCases.dropFirst(), id: \.self) {
                                Text($0.displayText)
                            }
                        }
                    }
                    .id(vm.uuid)
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .onChange(of: vm.year) { _ in vm.getCampuses() }
                    Text("|").font(.callout).foregroundColor(.secondary)
                    ForEach(SortOption.allCases, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getCampuses() }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
            }.padding([.leading, .trailing])
            Divider()
            List {
                if let campusArray = vm.allCampuses[vm.year.rawValue] {
                    ForEach(campusArray, id: \.self) { campus in
                        NavigationLink {
                            CampusDetailView(campus: campus, purchased: vm.purchased)
                        } label: {
                            CampusRow(campus: campus)
                        }
                        .isDetailLink(true)
                        .listRowBackground((Color(UIColor.systemBackground)))
                    }
                }
            }
            .accessibilityIdentifier("campusListView")
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("Campuses")
        .padding(.bottom)
        .alert(isPresented: $vm.presentBuyAlert) {
            Alert(
                title: Text("2022 U of M Salary Data is available to load for $1.99 on the Home Screen."),
                primaryButton: .default(Text("Home")) {
                    AppState.shared.viewID = UUID()
                },
                secondaryButton: .cancel())
        }
        .onChange(of: store.purchasedYears) { year in
            Task {
                    AppState.shared.purchased = .twentyTwo
            }
        }
        .onAppear(perform: { vm.setButtons(check: AppState.shared.purchased) })
        .onAppear(perform: { vm.getCampuses() })
        .onAppear(perform: { vm.createUUID() })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}

struct CampusRow: View {
    let campus: CampusViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(campus.campusName).font(.headline)
            Text("People on campus: " + campus.campusCount).textStyle(DetailData())
            Text("Avg. Annual FTR: " + campus.campusAverageAnnual).textStyle(DetailData())
        }
    }
}

struct CampusListView_Previews: PreviewProvider {
    static var previews: some View {
        CampusListView()
    }
}
