//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI
import Charts

struct PersonInsightView: View {
    
    @StateObject private var vm = PersonInsightViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let person: PersonViewModel
    // let title: TitleViewModel
    
    var body: some View {
        VStack {
            CloseInsightView()
            Text(person.fullName).textStyle(DetailData())
                .font(.headline)

            Divider()
        }


        ScrollView(.vertical) {

            Text("Annual Full-Time Rate").font(.headline)
            Text("Yearly % Change").font(.headline)

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .center){
                        HStack(alignment: .center){
                            ForEach(vm.personsInsight, id: \.self ) { person in
                                Spacer()
                                VStack(alignment: .center){
                                    Text(String(person.year)).textStyle(DetailData())
                                    Text(person.apptAnnualFTR).textStyle(DetailData())
                                }
                                Spacer()
                            }
                        }
                        HStack {
                            ForEach(vm.salaries, id: \.self) { salary in
                                Spacer()
                                Text("\(salary, specifier: "%.2f")%").textStyle(DetailData())
                                Spacer()
                            }
                        }
                    }
                    .frame(minWidth: geometry.size.width)
                }
            }.frame(height: 70)
            Divider()
       
            //MARK: There are frame sizes in the older version
            VStack {
                PersonLineChartView(person: person)
            }.frame(height: 200)
        }
        //MARK: Wrap these all into one function in the view model
        .onAppear(perform: {vm.getCampuses(vm: person)})
        .onAppear(perform: {vm.getPersons(vm: person)})
        .onAppear(perform: {vm.getPercentChange()})
        .onAppear(perform: {vm.getTitles(vm: person)})
        .onAppear(perform: {vm.getDepartments(vm: person)})
        .onAppear(perform: {vm.getChartData()})
        
        
    }
}


//struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
//}
