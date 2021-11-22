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
//            ForEach(vm.personsInsight, id: \.self) { person in
//                Text(String(person.year) + person.fullName)
//
//            }
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    PercentChangeView(persons: vm.personsInsight)
                        .frame(minWidth: geometry.size.width)
                }
//                .flipsForRightToLeftLayoutDirection(true)
//                    .environment(\.layoutDirection, .rightToLeft)


            }
            .frame(height: 70)
            
            
            Divider()
            
        }.onAppear(perform: {vm.getPersons(vm: person)})
    }
}

struct PercentChangeView: View {
    
    let persons: [PersonViewModel]
    
    
    var body: some View {
        
        VStack(alignment: .center){
            HStack(alignment: .center){
                ForEach(persons, id: \.self ) { person in
                    Spacer()
                    PercentChangeRowOne(person: person)
//                        .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    Spacer()
                    
                }
                
            }
            PercentChangeRowTwo(salaries: Person.personPercentChange(persons))
//                .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        }
    }
}


struct PercentChangeRowOne: View {
    var person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .center){
            Text(String(person.year)).textStyle(DetailData())
            Text(person.apptAnnualFTR).textStyle(DetailData())
        }
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






//struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
//}
