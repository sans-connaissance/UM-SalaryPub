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
            CloseInsightViewButton()
            Text(person.fullName).font(.headline)
            Divider()
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
                                    /// rotation effects are used to enable right to left scrolling and formatting.
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
                Spacer()
                if horizontalSizeClass == .compact {
                    PersonLineChartView(
                        showTitleAverage: $vm.showTitleAverage,
                        showDepartmentAverage: $vm.showDepartmentAverage,
                        showCampusAverage: $vm.showCampusAverage,
                        showAnnualFTR: $vm.showAnnualFTR,
                        person: person, year: year)
                        .frame(width: 370, height: 370, alignment: .leading)
                } else {
                    PersonLineChartView(
                        showTitleAverage: $vm.showTitleAverage,
                        showDepartmentAverage: $vm.showDepartmentAverage,
                        showCampusAverage: $vm.showCampusAverage,
                        showAnnualFTR: $vm.showAnnualFTR,
                        person: person, year: year)
                        .frame(width: 470, height: 470, alignment: .leading)
                }
            }
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    ChartLabel(labelTitle: "Annual FTR", labelData: person.fullName)
                    ChartLabel(labelTitle: "Campus Avg. FTR", labelData: person.campus)
                    ChartLabel(labelTitle: "Department Avg. FTR", labelData: person.department)
                    ChartLabel(labelTitle: "Title Avg. FTR", labelData: person.title)
                }
               Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                    ChartSwitch(isOn: $vm.showAnnualFTR, color: .systemGreen)
                    ChartSwitch(isOn: $vm.showCampusAverage, color: .systemBlue)
                    ChartSwitch(isOn: $vm.showDepartmentAverage, color: .systemPurple)
                    ChartSwitch(isOn: $vm.showTitleAverage, color: .systemOrange)
                }
            }.padding([.bottom, .top])
        }
        .onAppear(perform: { vm.getPersons(vm: person) })
        .onAppear(perform: { vm.getPercentChange() })
        .onAppear(perform: { vm.getCampuses(vm: person, year: year) })
        .onAppear(perform: { vm.getTitles(vm: person, year: year) })
        .onAppear(perform: { vm.getDepartments(vm: person, year: year) })
        .onAppear(perform: { vm.getChartData() })
    }
}

struct ChartLabel: View {
    var labelTitle: String
    var labelData: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelTitle).textStyle(SmallGrey())
            Text(labelData).font(.subheadline)
        }
        .padding(.leading)
        .multilineTextAlignment(.leading)
    }
}

struct ChartSwitch: View {
    @Binding var isOn: Bool
    var color: UIColor
    
    var body: some View {
        VStack(alignment: .trailing) {
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .init(color)))
                .labelsHidden()
                .padding(.trailing)
        }
    }
}
