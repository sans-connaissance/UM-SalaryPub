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
        
        ScrollView{
            
            VStack(alignment: .center) {
                ForEach(vm.titlesDetail.reversed(), id: \.self) { title in
                    Divider()
                    
                    Section(header: Text(String(title.year)).bold()) {
                        Divider()
                        
                        VStack {
                            HStack(spacing: 5){
                                Spacer()
                                TitleDetailRowLeft(title: title)
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
        .onAppear(perform: {vm.getTitles(vm: title)})
    }
}

struct TitleDetailRowRight: View {
    let title: TitleViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
            Group{
                Text("Avg. Annual FTR").textStyle(SmallGrey())
                Text(title.titleAverageAnnual).textStyle(DetailData())
                
            }
            Spacer()
            Group{
                Text("Median Annual FTR").textStyle(SmallGrey())
                Text(title.titleMedianAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Max Annual FTR").textStyle(SmallGrey())
                Text(title.titleMaxAnnual).textStyle(DetailData())
            }
            Spacer()
            Group{
                Text("Min Annual FTR").textStyle(SmallGrey())
                Text(title.titleMinAnnual).textStyle(DetailData())
            }
            Spacer()
        }
    }
}


struct TitleDetailRowLeft: View {
    
    let title: TitleViewModel
    
    var body: some View {

        VStack(alignment: .leading) {
            Spacer()
            Group{
                Text("People with Title").textStyle(SmallGrey())
//                NavigationLink(destination: PersonByTitleListView(titleFilter: title.titleName!, titleYear: String(title.titleYear))){
//                    Text("\(Int(title.titleCount))").textStyle(DetailData())
//                }.isDetailLink(true)
            }
            Spacer()
            Group{
                Text("Campuses with Title").textStyle(SmallGrey())
//                CampusWithTitle(campuses: title.personsWithTitle)
            }
            Spacer()
            Group{
                Text(" ").textStyle(SmallGrey())
                Text(" ").textStyle(DetailData())
            }
            Spacer()
        }
    }
}




struct TitleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TitleDetailView(title: TitleViewModel(title: Title(context: CoreDataManager.shared.viewContext)))
    }
}
