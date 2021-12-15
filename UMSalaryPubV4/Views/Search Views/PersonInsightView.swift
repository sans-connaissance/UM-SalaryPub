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
    let year: Int64

    var body: some View {
        VStack {
            CloseInsightView()
            Text(person.fullName).font(.headline)
            Divider()
//            VStack {
//                Text(String(vm.personCount))
//                Text(String(vm.titleCount))
//                Text(String(vm.departmentCount))
//                Text(String(vm.campusCount))
//            }
        }

        ScrollView(.vertical) {
            Text("Annual Full-Time Rate").font(.headline)
            Text("Yearly % Change").font(.headline)
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            ForEach(vm.personsInsight.reversed(), id: \.self) { person in
                                Spacer()
                                VStack(alignment: .center) {
                                    Text(String(person.year)).textStyle(DetailData())
                                    Text(person.apptAnnualFTR).textStyle(DetailData())
                                }.rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))

                                Spacer()
                            }
                        }
                        HStack {
                            ForEach(vm.salaries, id: \.self) { salary in
                                Spacer()
                                Text("\(salary, specifier: "%.2f")%").textStyle(DetailData())
                                Spacer()
                            }
                        }.rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    }.frame(minWidth: geometry.size.width)
                }
                .flipsForRightToLeftLayoutDirection(true)
                .environment(\.layoutDirection, .rightToLeft)
            }.frame(height: 70)
            Divider()
            VStack {
                PersonLineChartView(
                    showTitleAverage: $vm.showTitleAverage,
                    showDepartmentAverage: $vm.showDepartmentAverage,
                    showCampusAverage: $vm.showCampusAverage,
                    showAnnualFTR: $vm.showAnnualFTR,
                    person: person, year: year)
            }.frame(width: 370, height: 370, alignment: .leading)
            VStack {
                ChartSwitch(isOn: $vm.showAnnualFTR,
                            switchTitle: "Annual FTR",
                            switchData: person.fullName,
                            color: .systemGreen)
                ChartSwitch(isOn: $vm.showCampusAverage,
                            switchTitle: "Campus Avg. FTR",
                            switchData: person.campus,
                            color: .systemBlue)
                ChartSwitch(isOn: $vm.showDepartmentAverage,
                            switchTitle: "Department Avg. FTR",
                            switchData: person.department,
                            color: .systemPurple)
                ChartSwitch(isOn: $vm.showTitleAverage,
                            switchTitle: "Title Avg. FTR",
                            switchData: person.title,
                            color: .systemOrange)
            }.padding(.leading)
        }

        // MARK: Wrap these all into one function in the view model

        .onAppear(perform: { vm.getPersons(vm: person) })
        .onAppear(perform: { vm.getPercentChange() })
        .onAppear(perform: { vm.getCampuses(vm: person, year: year) })
        .onAppear(perform: { vm.getTitles(vm: person, year: year) })
        .onAppear(perform: { vm.getDepartments(vm: person, year: year) })
        .onAppear(perform: { vm.getChartData() })
    }
}

// struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
// }
