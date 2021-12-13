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

    
    // CHECK HOLLY DAUL for messed up INSIGHTS BUTTON
    //IS THERE A WAY TO USE LESS MEMORY?? MAYBE THE MEMORY USE ISNT THAT BAD
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(SortOption.personList, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getPersonsByDepartment(vm: department) }
                    }
                }
            }.padding([.leading, .trailing])
            Divider()
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
            }
            .listStyle(GroupedListStyle())
        }
        .navigationTitle(department.departmentName)
        .padding(.bottom)
        .onAppear(perform: { vm.setButtons() })
        .onAppear(perform: { vm.getPersonsByDepartment(vm: department) })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}

// struct PersonListByDepartmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonListByDepartmentView()
//    }
// }
