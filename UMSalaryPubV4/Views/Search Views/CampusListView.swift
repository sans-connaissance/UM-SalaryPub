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
                
                ForEach(SortOption.allCases, id: \.self) { button in
                    SortListButton(selected: button, sortButtons: $vm.sortButtons)
                    .onChange(of: vm.sortButtons) { _ in vm.getCampuses()}}
                
            }
            Divider()
            List {
                
                if let campusArray = vm.allCampuses[vm.year.rawValue] {
                    ForEach(campusArray, id: \.self) { campus in
                        NavigationLink {
                            CampusDetailView(campus: campus)
                        } label: {
                            CampusRow(campus: campus)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Campuses")
            .onAppear(perform: { vm.setButtons()})
            .onAppear(perform: { vm.getCampuses()})
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
