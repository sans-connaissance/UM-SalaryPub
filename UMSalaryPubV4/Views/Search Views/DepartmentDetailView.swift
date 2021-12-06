//
//  DepartmentDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

import SwiftUI

struct DepartmentDetailView: View {
    @StateObject private var vm = DepartmentDetailViewModel()
    
    let department: DepartmentViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(vm.departmentsDetail.reversed(), id: \.self) { department in
                    Divider()
                    
                    Section(header: Text(String(department.year)).bold()) {
                        Divider()
                        
                        VStack {
                            HStack(spacing: 5) {
                                Spacer()
                                DepartmentDetailRowLeft(department: department)
                                Spacer()
                                DepartmentDetailRowRight(department: department)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(department.departmentName)
        .onAppear(perform: { vm.getDepartments(vm: department) })
    }
}

struct DepartmentDetailRowRight: View {
    let department: DepartmentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("Avg. Annual FTR").textStyle(SmallGrey())
                Text(department.departmentAverageAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Median Annual FTR").textStyle(SmallGrey())
                Text(department.departmentMedianAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Max Annual FTR").textStyle(SmallGrey())
                Text(department.departmentMaxAnnual).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Min Annual FTR").textStyle(SmallGrey())
                Text(department.departmentMinAnnual).textStyle(DetailData())
            }
            Spacer()
        }
    }
}

struct DepartmentDetailRowLeft: View {
    let department: DepartmentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("People in Department").textStyle(SmallGrey())
//                NavigationLink(destination: PersonByDepartmentListView(departmentFilter: department.departmentName!, departmentYear: String(department.departmentYear))){
//                    Text("\(Int(department.departmentCount))").textStyle(DetailData())
//                }.isDetailLink(true)
            }
            Spacer()
            Group {
                Text("Campuses with Department").textStyle(SmallGrey())
//                CampusWithDepartment(campuses: department.personsInDepartment)
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

struct DepartmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentDetailView(department: DepartmentViewModel(department: Department(context: CoreDataManager.shared.viewContext)))
    }
}
