//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import Charts
import SwiftUI

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
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            ForEach(vm.personsInsight, id: \.self) { person in
                                Spacer()
                                VStack(alignment: .center) {
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
            
            // MARK: There are frame sizes in the older version

            VStack {
                PersonLineChartView(showTitleAverage: $vm.showTitleAverage, showDepartmentAverage: $vm.showDepartmentAverage, showCampusAverage: $vm.showCampusAverage, showAnnualFTR: $vm.showAnnualFTR, person: person)
            }.frame(width: 370, height: 370, alignment: .leading)
            VStack {
                ChartSwitch(isOn: $vm.showAnnualFTR, switchTitle: "Annual FTR", switchData: person.fullName, color: .systemGreen)
                ChartSwitch(isOn: $vm.showCampusAverage, switchTitle: "Campus Avg. FTR", switchData: person.campus, color: .systemBlue)
                ChartSwitch(isOn: $vm.showDepartmentAverage, switchTitle: "Department Avg. FTR", switchData: person.department, color: .systemPurple)
                ChartSwitch(isOn: $vm.showTitleAverage, switchTitle: "Title Avg. FTR", switchData: person.title, color: .systemOrange)
            }
        }

        // MARK: Wrap these all into one function in the view model

        .onAppear(perform: { vm.getCampuses(vm: person) })
        .onAppear(perform: { vm.getPersons(vm: person) })
        .onAppear(perform: { vm.getPercentChange() })
        .onAppear(perform: { vm.getTitles(vm: person) })
        .onAppear(perform: { vm.getDepartments(vm: person) })
        .onAppear(perform: { vm.getChartData() })
    }
}

// struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
// }
