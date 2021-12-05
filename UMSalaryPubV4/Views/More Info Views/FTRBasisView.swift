//
//  FTRBasisView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 4/14/21.
//

import SwiftUI

struct FTRBasisView: View {
    var body: some View {
        List {
            Section(header: Text("Appointment Full-Time Rate Basis")) {
                Text("The length of time it takes for this person to earn their Annual Full-Time Rate.").textStyle(DetailData())
            }
        }.navigationTitle("Definition")
    }
}

struct FTRBasisView_Previews: PreviewProvider {
    static var previews: some View {
        FTRBasisView()
    }
}
