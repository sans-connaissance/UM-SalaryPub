//
//  CampusDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct CampusDetailView: View {
    @StateObject private var vm = CampusDetailViewModel()
    let campus: CampusViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(vm.campusesDetail.reversed(), id: \.self) { campus in
                    Divider()
                    
                    Section(header: Text(String(campus.year)).bold()) {
                        Divider()
                        
                        VStack {
                            HStack(spacing: 5) {
                                Spacer()
                                CampusDetailRowLeft(campus: campus)
                                Spacer()
                                CampusDetailRowRight(campus: campus)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(campus.campusName)
        .padding(.bottom)
        .onAppear(perform: { vm.getCampuses(vm: campus) })
        .toolbar { ToolbarItem(placement: .navigationBarTrailing) {
            if UIDevice.current.userInterfaceIdiom != .pad { HomeButton() }
        }
        ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
    }
}

struct CampusDetailRowLeft: View {
    let campus: CampusViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("People on campus").textStyle(SmallGrey())
                Text(campus.campusCount).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text(" ").textStyle(SmallGrey())
                Text(" ").textStyle(DetailData())
            }
            Spacer()
            Group {
                Text(" ").textStyle(SmallGrey())
                Text(" ").textStyle(DetailData())
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

struct CampusDetailRowRight: View {
    let campus: CampusViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("Avg. Annual FTR").textStyle(SmallGrey())
                Text(campus.campusAverageAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Median Annual FTR").textStyle(SmallGrey())
                Text(campus.campusMedianAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Max Annual FTR").textStyle(SmallGrey())
                Text(campus.campusMaxAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Min Annual FTR").textStyle(SmallGrey())
                Text(campus.campusMinAnnual).textStyle(DetailData())
            }
            Spacer()
        }
    }
}



struct CampusDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CampusDetailView(campus: CampusViewModel(campus: Campus(context: CoreDataManager.shared.viewContext)))
    }
}
