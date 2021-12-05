//
//  GeneralFundView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 4/14/21.
//

import SwiftUI

struct GeneralFundView: View {
    var body: some View {
        List {
            Section(header: Text("Amount from General Fund")) {
                Text("This dollar figure is the amount of a person's Annual Full-Time Rate that is paid for from the General Fund. The General Fund's primary sources of revenue are student tuition, fees, and state appropriations.").textStyle(DetailData())
            }
        }.navigationTitle("Definition")
    }
}

struct GeneralFundView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralFundView()
    }
}
