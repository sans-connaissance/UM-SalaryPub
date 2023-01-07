//
//  TitleView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI

struct TitleListView: View {
    @StateObject private var vm = TitleListViewModel()
    @StateObject private var store = StoreKitManager()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getTitles() }
                .onTapGesture {
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
                    .onChange(of: vm.year) { _ in vm.getTitles() }
                    Text("|").font(.callout).foregroundColor(.secondary)
                    ForEach(SortOption.allCases, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getTitles() }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
            }.padding([.leading, .trailing])
            Divider()
            ///Main List View
            List {
                if let titleArray = vm.allTitles[vm.year.rawValue] {
                    ForEach(titleArray, id: \.self) { title in
                        NavigationLink {
                            TitleDetailView(title: title)
                        } label: {
                            TitleRow(title: title)
                        }
                        .isDetailLink(true)
                        .listRowBackground((Color(UIColor.systemBackground)))
                    }
                }
            }
            .accessibilityIdentifier("titleListView")
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("Titles")
        .padding(.bottom)
        .alert(isPresented: $vm.presentBuyAlert) {
            Alert(
                title: Text("2022 U of M Salary Data is available to load for $1.99."),
                primaryButton: .default(Text("Buy Now")) {
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
        .onAppear(perform: { vm.getTitles() })
        .onAppear(perform: { vm.createUUID() })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}

struct TitleRow: View {
    let title: TitleViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title.titleName).font(.headline)
            Text("People with title: " + title.titleCount).textStyle(DetailData())
            Text("Avg. Annual FTR: " + title.titleAverageAnnual).textStyle(DetailData())
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleListView()
    }
}
