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
                .onChange(of: vm.searchText) { _ in vm.getTitles()}
            
            HStack {
                Picker("Select year", selection: $vm.year) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: vm.year) { _ in vm.getTitles()}
                
                sortButtons
                
            }
            Divider()
            List {
                
                if let titleArray = vm.allTitles[vm.year.rawValue] {
                    ForEach(titleArray, id: \.self) { title in
                        NavigationLink {
                            TitleDetailView(title: title)
                        } label: {
                            TitleRow(title: title)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Titles")
            .onAppear(perform: { vm.getTitles()})
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
                .onChange(of: vm.sortByMoneyDescending){ _ in vm.getTitles()}
            
            SortByMoneyAscendingButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByMoneyAscending){ _ in vm.getTitles()}
            
            SortAlphabeticallyButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortAlphabetically){ _ in vm.getTitles()}
            
            SortByPersonCountDescending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountDescending){ _ in vm.getTitles()}
            
            SortByPersonCountAscending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountAscending){ _ in vm.getTitles()}
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
        TitleListView()
    }
}
