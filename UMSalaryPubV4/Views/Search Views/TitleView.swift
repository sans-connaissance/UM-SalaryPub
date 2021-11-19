//
//  TitleView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI

struct TitleView: View {
    
    @StateObject private var vm = TitleListViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.titleSearch()}
            
            HStack {
                Picker("Select year", selection: $vm.year) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: vm.year) { _ in vm.titleSearch()}
                
                sortButtons
                
            }
            Divider()
            List {
                
                if let titlearray = vm.allTitles[vm.year.rawValue] {
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
            .navigationTitle("Titles")
            .onAppear(perform: { vm.titleSearch()})
        }
    }
    
    var sortButtons: some View {
        
        HStack {
            SortByMoneyDescendingButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByMoneyDescending){ _ in vm.titleSearch()}
            
            SortByMoneyAscendingButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByMoneyAscending){ _ in vm.titleSearch()}
            
            SortAlphabeticallyButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortAlphabetically){ _ in vm.titleSearch()}
            
            SortByPersonCountDescending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountDescending){ _ in vm.titleSearch()}
            
            SortByPersonCountAscending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountAscending){ _ in vm.titleSearch()}
        }
    }
}

struct TitleRow: View {
    let title: TitleViewModel
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            Text(title.titleName).font(.headline)
            Text("People with title:" + title.titleCount).textStyle(DetailData())
            Text("Avg. Annual FTR: " + title.titleAverageAnnual).textStyle(DetailData())
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
