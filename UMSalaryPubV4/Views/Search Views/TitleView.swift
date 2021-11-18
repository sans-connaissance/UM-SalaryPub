//
//  TitleView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI

struct TitleView: View {
    @StateObject private var titleListVM = TitleListViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $titleListVM.searchText)
                .onChange(of: titleListVM.searchText) { _ in titleListVM.titleSearch()}
            
            HStack {
                Picker("Select year", selection: $titleListVM.selectedYear) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: titleListVM.selectedYear) { _ in titleListVM.titleSearch()}

                sortByMoneyDescendingButton
                sortByMoneyAscendingButton
                sortAlphabeticallyButton
            }
            Divider()
            List {
                
                if let titlearray = titleListVM.allTitles[titleListVM.selectedYear.rawValue] {
                    ForEach(titlearray, id: \.self) { title in
                        NavigationLink {
                            EmptyView()
                        } label: {
                            TitleRow(title: title)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("People")
            .onAppear(perform: { titleListVM.titleSearch()
            })
        }
    }
    var sortAlphabeticallyButton: some View {
        Button {
            titleListVM.sortByMoneyDescending = false
            titleListVM.sortByMoneyAscending = false
            titleListVM.sortAlphabetically = true
            titleListVM.titleSearch()
            
        } label: {
            Text("abc")
                .foregroundColor(titleListVM.sortAlphabetically ? .blue : .gray)
        }
    }
    
    var sortByMoneyDescendingButton: some View {
        Button {
            titleListVM.sortByMoneyDescending = true
            titleListVM.sortByMoneyAscending = false
            titleListVM.sortAlphabetically = false
            titleListVM.titleSearch()
        } label: {
            Text("$$$")
                .foregroundColor(titleListVM.sortByMoneyDescending ? .blue : .gray)
        }
    }
    
    var sortByMoneyAscendingButton: some View {
        Button {
            titleListVM.sortByMoneyDescending = false
            titleListVM.sortByMoneyAscending = true
            titleListVM.sortAlphabetically = false
            titleListVM.titleSearch()
        } label: {
            Text("$")
                .foregroundColor(titleListVM.sortByMoneyAscending ? .blue : .gray)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
