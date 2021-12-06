//
//  PersonDetailView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/13/21.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var vm = PersonDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            InsightsButton(isPresented: $vm.isPresented)
                .padding()
                .fullScreenCover(isPresented: $vm.isPresented) {
                    PersonInsightView(person: person)
                }
        }
        
        ScrollView {
            VStack(alignment: .center) {
                ForEach(vm.personsDetail.reversed(), id: \.self) { person in
                    Divider()
                    
                    Section(header: Text(String(person.year)).bold()) {
                        Divider()
                        
                        VStack {
                            HStack(spacing: 5) {
                                Spacer()
                                PersonDetailRowLeft(person: person, vm: vm)
                                Spacer()
                                PersonDetailRowRight(person: person)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(person.fullName)
        .onAppear(perform: { vm.getTitle(vm: person) })
        .onAppear(perform: { vm.getDepartment(vm: person) })
        .onAppear(perform: { vm.getCampus(vm: person) })
        .onAppear(perform: { vm.getPersons(vm: person) })
    }
}

struct PersonDetailRowLeft: View {
    let person: PersonViewModel
    let vm: PersonDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Campus").textStyle(SmallGrey())
                NavigationLink {
                    if let campus = vm.campusForDetailView.first {
                        CampusDetailView(campus: campus)
                    }
                } label: {
                    Text(person.campus).textStyle(DetailData())
                }
            }
            Spacer()
            Group {
                Text("Department").textStyle(SmallGrey())
                NavigationLink {
                    if let department = vm.departmentForDetailView.first {
                        DepartmentDetailView(department: department)
                    }
                } label: {
                    Text(person.department).textStyle(DetailData())
                }
            }
            Spacer()
            Group {
                Text("Title").textStyle(SmallGrey())
                NavigationLink {
                    if let title = vm.titleForDetailView.first {
                        TitleDetailView(title: title)
                    }
                } label: {
                    Text(person.title).textStyle(DetailData())
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

struct PersonDetailRowRight: View {
    let person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Annual Full-Time Rate (FTR)").textStyle(SmallGrey())
                Text(person.apptAnnualFTR).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Appointment FTR Basis").textStyle(SmallGrey())
                Text(person.apptFTRBasis).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Appointment Fraction").textStyle(SmallGrey())
                Text(person.apptFraction).textStyle(DetailData())
            }
            Spacer()
            Group {
                Text("Amount from General Fund").textStyle(SmallGrey())
                Text(person.amtSalaryFromGeneralFund).textStyle(DetailData())
            }
            Spacer()
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: PersonViewModel(person: Person(context: CoreDataManager.shared.viewContext)))
    }
}
