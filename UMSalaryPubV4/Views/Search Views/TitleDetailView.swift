//
//  TitleDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct TitleDetailView: View {
    @StateObject private var vm = TitleDetailViewModel()
    let title: TitleViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(vm.titlesDetail.reversed(), id: \.self) { title in
                    Divider()
                    Section(header: Text(String(title.year)).bold()) {
                        Divider()
                        VStack {
                            HStack(spacing: 5) {
                                Spacer()
                                TitleDetailRowLeft(
                                    title: title,
                                    campusesWithTitle: vm.campusesWithTitle(vm: title))
                                Spacer()
                                TitleDetailRowRight(title: title)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(title.titleName)
        .padding(.bottom)
        .onAppear(perform: { vm.getTitles(vm: title) })
        .toolbar { ToolbarItem(placement: .navigationBarTrailing) {
            if UIDevice.current.userInterfaceIdiom != .pad { HomeButton() }
        }
        ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
    }
}

struct TitleDetailRowLeft: View {
    let title: TitleViewModel
    let campusesWithTitle: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("People with Title").textStyle(SmallGrey())
                NavigationLink {
                    PersonListByTitleView(title: title)
                 
                } label: {
                    Text(title.titleCount).textStyle(DetailData())
                }
            }
            Spacer()
            Group {
                Text("Campuses with Title").textStyle(SmallGrey())
                ForEach(campusesWithTitle, id: \.self) { campus in
                    Text(campus).textStyle(DetailData())
                }
            }
            Spacer()
            Group {
                Text(" ").textStyle(SmallGrey())
                Text(" ").textStyle(DetailData())
            }
            Spacer()
        }
    }
}

struct TitleDetailRowRight: View {
    let title: TitleViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("Avg. Annual FTR").textStyle(SmallGrey())
                Text(title.titleAverageAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Median Annual FTR").textStyle(SmallGrey())
                Text(title.titleMedianAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Max Annual FTR").textStyle(SmallGrey())
                Text(title.titleMaxAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Min Annual FTR").textStyle(SmallGrey())
                Text(title.titleMinAnnual).textStyle(DetailData())
            }
            Spacer()
        }
    }
}
