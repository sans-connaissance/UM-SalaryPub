//
//  AnnualFTRView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 4/14/21.
//

import SwiftUI

struct AnnualFTRView: View {
    var body: some View {
        List {
            Section(header: Text("Annual Full-Time Rate")) {
                Text("The Annual Full-Time Rate is the amount of money a person makes for the indicated period of their appointment.").textStyle(DetailData())
            }
        }.navigationTitle("Definition")
    }
}

struct AnnualFTRView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualFTRView()
    }
}
