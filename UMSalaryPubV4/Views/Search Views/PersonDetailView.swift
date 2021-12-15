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
        HStack {
            VStack(alignment: .leading) {
                if vm.personInsightCheck(persons: vm.personsDetail) == true {
                    InsightsButton(isPresented: $vm.isPresented)
                        .padding()
                        .fullScreenCover(isPresented: $vm.isPresented) {
                            PersonInsightView(
                                person: person,
                                year: vm.personsDetail.reversed()[0].year)
                        }
                } else {
                    Text("Insights not available \n(same name or multiple appointments)").textStyle(SmallGrey())
                        .padding(.leading)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
        Divider()
        ScrollView {
            VStack(alignment: .center) {
                ForEach(vm.personsDetail.reversed(), id: \.self) { person in
                    Divider()

                    Section(header: Text(String(person.year)).bold()) {
                        Divider()
                        VStack {
                            HStack(spacing: 5) {
                                Spacer()
                                PersonDetailRowLeft(
                                    person: person,
                                    title: vm.getTitle(vm: person),
                                    department: vm.getDepartment(vm: person),
                                    campus: vm.getCampus(vm: person))
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
        .padding(.bottom)
        .onAppear(perform: { vm.getPersons(vm: person) })
        .toolbar { ToolbarItem(placement: .navigationBarTrailing) {
            if UIDevice.current.userInterfaceIdiom != .pad { HomeButton() }
        }
        ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
    }
}

struct PersonDetailRowLeft: View {
    let person: PersonViewModel
    let title: [TitleViewModel]
    let department: [DepartmentViewModel]
    let campus: [CampusViewModel]

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Campus").textStyle(SmallGrey())
                NavigationLink {
                    if let campus = campus.first {
                        CampusDetailView(campus: campus)
                    }
                } label: {
                    Text(person.campus).textStyle(DetailData())
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
            Group {
                Text("Department").textStyle(SmallGrey())
                NavigationLink {
                    if let department = department.first {
                        DepartmentDetailView(department: department)
                    }
                } label: {
                    Text(person.department).textStyle(DetailData())
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
            Group {
                Text("Title").textStyle(SmallGrey())
                NavigationLink {
                    if let title = title.first {
                        TitleDetailView(title: title)
                    }
                } label: {
                    Text(person.title).textStyle(DetailData())
                        .multilineTextAlignment(.leading)
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
