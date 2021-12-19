//
//  DepartmentListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct DepartmentListView: View {
    @StateObject private var vm = DepartmentListViewModel()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getDepartments() }
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
                    .onChange(of: vm.year) { _ in vm.getDepartments() }
                    Text("|").font(.callout).foregroundColor(.secondary)
                    ForEach(SortOption.allCases, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getDepartments() }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
            }.padding([.leading, .trailing])
            Divider()
            List {
                if let departmentArray = vm.allDepartments[vm.year.rawValue] {
                    ForEach(departmentArray, id: \.self) { department in
                        NavigationLink {
                            DepartmentDetailView(department: department)
                        } label: {
                            DepartmentRow(department: department)
                        }
                        .isDetailLink(true)
                        .listRowBackground((Color(UIColor.systemBackground)))
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("Departments")
        .padding(.bottom)
        .onAppear(perform: { vm.getDepartments() })
        .onAppear(perform: { vm.setButtons() })
        .onAppear(perform: { vm.createUUID() })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}

struct DepartmentRow: View {
    let department: DepartmentViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(department.departmentName).font(.headline)
            Text("People in Department: " + department.departmentCount).textStyle(DetailData())
            Text("Avg. Annual FTR: " + department.departmentAverageAnnual).textStyle(DetailData())
        }
    }
}

struct DepartmentListView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentListView()
    }
}
