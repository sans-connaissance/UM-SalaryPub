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
            ///Sort options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(SortOption.personList, id: \.self) { button in
                        SortListButton(selected: button, sortButtons: $vm.sortButtons)
                            .onChange(of: vm.sortButtons) { _ in vm.getPersonsByTitle(vm: title) }
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
        .navigationTitle(title.titleName)
        .padding(.bottom)
        .onAppear(perform: { vm.getPersonsByTitle(vm: title) })
        .onAppear(perform: { vm.setButtons() })
        .onDisappear(perform: { vm.flipFirstAppear() })
    }
}
