//
//  MoreInfoView.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 1/23/21.
//

import SwiftUI
import StoreKit

struct MoreInfoView: View {
    var body: some View {
        VStack {
            Divider()
            List {
                Section(header: Text("Restore Purchase on Device")) {
                    Button {
                        Task {
                            try? await AppStore.sync()
                        }
                    } label: {
                        Text("Restore Purchase").textStyle(DetailData())
                    }
                }
                Section(header: Text("Contact")) {
                    Text("umichsalarypub@icloud.com")
                        .textStyle(DetailData())
                }
                Section(header: Text("Definitions")) {
                    NavigationLink(destination: GeneralFundView()) {
                        Text("Amount from General Fund").font(.headline)
                    }
                    NavigationLink(destination: AnnualFTRView()) {
                        Text("Annual Full-Time Rate (FTR)").font(.headline)
                    }
                    NavigationLink(destination: AppointmentFractionView()) {
                        Text("Appointment Fraction").font(.headline)
                    }
                    NavigationLink(destination: FTRBasisView()) {
                        Text("Appointment Full-Time Rate (FTR) Basis").font(.headline)
                    }
                }

                Section(header: Text("Data")) {
                    VStack(alignment: .leading) {
                        Text("In accordance with the Freedom of Information Act, the University of Michigan is required to produce a publicly available annual Salary Disclosure Report. The publicly available Salary Disclosure Reports used in the production of UM SalaryPub are available at:").textStyle(DetailData())
                        UMLinkView()
                        Text("Insights and other statistics available in UM SalaryPub were derived by Frankfurt Industries, LLC., and are provided as-is, with no expressed or implied guarantees regarding the validity or accuracy of the content. UM SalaryPub is not affiliated with or endorsed by the University of Michigan or any other entity.").textStyle(DetailData())
                    }
                }

            }.listStyle(GroupedListStyle())
        }
        .navigationTitle("More Info")
        .padding()
        .embedInNavigationView() ///I think this is so cool
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UMLinkView: View {
    var body: some View {
        Link("HR Reports and Data Services", destination: URL(string: "https://hr.umich.edu/working-u-m/management-administration/hr-reports-data-services/hr-data-requests-standard-reports")!)
            .font(.subheadline)
    }
}

struct EmailLinkView: View {
    var body: some View {
        Link("umichsalarypub@icloud.com", destination: URL(string: "umichsalarypub@icloud.com")!)
            .font(.subheadline)
    }
}

struct MoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoView()
    }
}
