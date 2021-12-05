//
//  AppointmentFractionView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 4/14/21.
//

import SwiftUI

struct AppointmentFractionView: View {
    var body: some View {
        List {
            Section(header: Text("Appointment Fraction")) {
                Text("Examples: \n1.00 = full-time appointment \n0.50 = half-time appointment \n0.25 = quarter-time appointment").textStyle(DetailData())
            }
        }.navigationTitle("Definition")
    }
}

struct AppointmentFractionView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentFractionView()
    }
}
