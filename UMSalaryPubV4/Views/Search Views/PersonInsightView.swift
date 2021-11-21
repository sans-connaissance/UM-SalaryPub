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
            
        }
    }
}






//struct PersonInsightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonInsightView()
//    }
//}
