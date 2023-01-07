//
//  DepartmentListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct DepartmentListView: View {
    @StateObject private var vm = DepartmentListViewModel()
    @StateObject private var store = StoreKitManager()

    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)
                .onChange(of: vm.searchText) { _ in vm.getDepartments() }
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
            ///Main List View
            List {
                if let departmentArray = vm.allDepartments[vm.year.rawValue] {
                    ForEach(departmentArray, id: \.self) { department in
                        NavigationLink {
                            DepartmentDetailView(department: department, purchased: vm.purchased)
                        } label: {
                            DepartmentRow(department: department)
                        }
                        .isDetailLink(true)
                        .listRowBackground((Color(UIColor.systemBackground)))
                    }
                }
            }
            .accessibilityIdentifier("departmentListView")
            .listStyle(GroupedListStyle())
            .id(vm.uuid)
        }
        .navigationTitle("Departments")
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
        .onAppear(perform: { vm.getDepartments() })
        .onAppear(perform: { vm.setButtons(check: AppState.shared.purchased) })
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
