//
//  PersonListByDepartmentView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 12/7/21.
//

import SwiftUI

struct PersonListByDepartmentView: View {
    @StateObject private var vm = PersonListByDepartmentViewModel()
    let department: DepartmentViewModel

    var body: some View {
        VStack {
            ///Sort options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(SortOption.personList, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getPersonsByDepartment(vm: department) }
                    }
                }
            }.padding([.leading, .trailing])
            Divider()
            //Main List View
            List {
                ForEach(vm.personsByTitle, id: \.self) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        PersonRow(person: person)
                    }
                    .isDetailLink(true)
                    .listRowBackground((Color(UIColor.systemBackground)))
                }
            }.listStyle(GroupedListStyle())
        }
        .navigationTitle(department.departmentName)
        .padding(.bottom)
        .onAppear(perform: { vm.getPersonsByDepartment(vm: department) })
        .onAppear(perform: { vm.setButtons() })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}
