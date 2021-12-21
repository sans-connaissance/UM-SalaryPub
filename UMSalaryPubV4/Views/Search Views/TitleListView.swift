//
//  TitleView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI

struct TitleListView: View {
    @StateObject private var vm = TitleListViewModel()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getTitles() }
                .onTapGesture {
                    if vm.searchText == " " {
                        vm.searchText = ""
                    }
                }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    Picker("Select year", selection: $vm.year) {
                        ForEach(FetchYear.allCases, id: \.self) {
                            Text($0.displayText)
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
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("Titles")
        .padding(.bottom)
        .onAppear(perform: { vm.setButtons() })
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
