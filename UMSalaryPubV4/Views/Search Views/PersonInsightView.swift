//
//  PersonInsightViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/20/21.
//

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
            Divider()
        }
        
        ScrollView(.vertical) {
            
            Text("Annual Full-Time Rate").font(.headline)
            Text("Yearly % Change").font(.headline)

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
//                    PercentChangeView(persons: vm.personsInsight)
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
                        PercentChangeRowTwo(salaries: Person.personPercentChange(vm.personsInsight))
                        

                    }
                        .frame(minWidth: geometry.size.width)
                }

            }
            .frame(height: 70)
            
            
            Divider()
            
        }.onAppear(perform: {vm.getPersons(vm: person)})
    }
}

struct PercentChangeRowTwo: View {
    var salaries: [Double]
    
    var body: some View {
        HStack{
            ForEach(salaries, id: \.self) { salary in
                Spacer()
                Text("\(salary, specifier: "%.2f")%").textStyle(DetailData())
                Spacer()
            }
        }
    }
}

//struct PercentChangeView: View {
//
//    let persons: [PersonViewModel]
//
//
//    var body: some View {
//
//        VStack(alignment: .center){
//            HStack(alignment: .center){
//                ForEach(persons, id: \.self ) { person in
//                    Spacer()
//                    VStack(alignment: .center){
//                        Text(String(person.year)).textStyle(DetailData())
//                        Text(person.apptAnnualFTR).textStyle(DetailData())
//                    }
//                    Spacer()
//
//                }
//
//            }
//            PercentChangeRowTwo(salaries: Person.personPercentChange(persons))
//
//
//        }
//    }
//}


//struct PercentChangeRowOne: View {
//    var person: PersonViewModel
//
//    var body: some View {
//        VStack(alignment: .center){
//            Text(String(person.year)).textStyle(DetailData())
//            Text(person.apptAnnualFTR).textStyle(DetailData())
//        }
//    }
//}








//struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
//}
