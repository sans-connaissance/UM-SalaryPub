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
                                DepartmentDetailRowLeft(department: department, campusesWithDepartment: vm.campusesWithDepartment(vm: department))
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
        .padding(.bottom)
        .onAppear(perform: { vm.getDepartments(vm: department) })
        .toolbar { ToolbarItem(placement: .navigationBarTrailing) {
            if UIDevice.current.userInterfaceIdiom != .pad { HomeButton() }
        }
        ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
    }
}

struct DepartmentDetailRowLeft: View {
    let department: DepartmentViewModel
    let campusesWithDepartment: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("People in Department").textStyle(SmallGrey())
                NavigationLink {
                    PersonListByDepartmentView(department: department)
                 
                } label: {
                    Text(department.departmentCount).textStyle(DetailData())
                }
            }
            Spacer()
            Group {
                Text("Campuses with Department").textStyle(SmallGrey())
                ForEach(campusesWithDepartment, id: \.self) { campus in
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

struct DepartmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentDetailView(department: DepartmentViewModel(department: Department(context: CoreDataManager.shared.viewContext)))
    }
}
