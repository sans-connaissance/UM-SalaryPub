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
            HStack {
                ForEach(SortOption.personList, id: \.self) { button in
                    SortListButton(selected: button, sortButtons: $vm.sortButtons)
                        .onChange(of: vm.sortButtons) { _ in vm.getPersonsByDepartment(vm: department) }
                }
            }
            Divider()
            List {
                ForEach(vm.personsByTitle, id: \.self) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        PersonRow(person: person)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(department.departmentName)
            .onAppear(perform: { vm.setButtons() })
            .onAppear(perform: { vm.getPersonsByDepartment(vm: department) })
        }
    }
}

//struct PersonListByDepartmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonListByDepartmentView()
//    }
//}
