//
//  CampusListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct CampusListView: View {
    
    @StateObject private var vm = CampusListViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getCampuses()}
            
            HStack {
                Picker("Select year", selection: $vm.year) {
                    ForEach(FetchYear.allCases, id: \.self) {
                        Text($0.displayText)
                    }
                }
                .onChange(of: vm.year) { _ in vm.getCampuses()}
                
                sortButtons
                
            }
            Divider()
            List {
                
                if let campusArray = vm.allCampuses[vm.year.rawValue] {
                    ForEach(campusArray, id: \.self) { campus in
                        NavigationLink {
                            EmptyView()
                        } label: {
                            CampusRow(campus: campus)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Campuses")
            .onAppear(perform: { vm.getCampuses()})
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
                .onChange(of: vm.sortByMoneyDescending){ _ in vm.getCampuses()}
            
            SortByMoneyAscendingButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByMoneyAscending){ _ in vm.getCampuses()}
            
            SortAlphabeticallyButton(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortAlphabetically){ _ in vm.getCampuses()}
            
            SortByPersonCountDescending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountDescending){ _ in vm.getCampuses()}
            
            SortByPersonCountAscending(
                sortByMoneyDescending: $vm.sortByMoneyDescending,
                sortByMoneyAscending: $vm.sortByMoneyAscending,
                sortAlphabetically: $vm.sortAlphabetically,
                sortByPersonCountDescending: $vm.sortByPersonCountDescending,
                sortByPersonCountAscending: $vm.sortByPersonCountAscending)
                .onChange(of: vm.sortByPersonCountAscending){ _ in vm.getCampuses()}
        }
    }
}

struct CampusRow: View {
    let campus: CampusViewModel

    var body: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            Text(campus.campusName).font(.headline)
            Text("People on campus:" + campus.campusCount).textStyle(DetailData())
            Text("Avg. Annual FTR: " + campus.campusAverageAnnual).textStyle(DetailData())
        }
    }
}

struct CampusListView_Previews: PreviewProvider {
    static var previews: some View {
        CampusListView()
    }
}
