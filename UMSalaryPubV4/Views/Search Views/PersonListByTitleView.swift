//
//  PersonByTitleListView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 12/6/21.
//

import SwiftUI

struct PersonListByTitleView: View {
    @StateObject private var vm = PersonListByTitleViewModel()
    let title: TitleViewModel

    var body: some View {
        VStack {
            HStack {
                ForEach(SortOption.personList, id: \.self) { button in
                    SortListButton(selected: button, sortButtons: $vm.sortButtons)
                        .onChange(of: vm.sortButtons) { _ in vm.getPersonsByTitle(vm: title) }
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
            .navigationTitle(title.titleName)
            .onAppear(perform: { vm.setButtons() })
            .onAppear(perform: { vm.getPersonsByTitle(vm: title) })
        }
    }
}

// struct PersonByTitleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonListByTitleView()
//    }
// }
