//
//  DashboardCountsView.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/2/21.
//

import CoreData
import SwiftUI


struct DashboardCountsView: View {
    
    @StateObject private var adminVM = AdminViewModel()
    
    var body: some View {
        
        //create a forEach here based on the adminVM.importYears.count
        
        // do I create a struct that represents the count? Like a PersonDetailView Struct or something or like a ViewCell of somekind
        
        
        List {
            
            
            ForEach(adminVM.importYears, id: \.self) { year in
                Section(header: Text(String(year))) {
                    if let personCount = adminVM.allPersons[year] {
                        let count = personCount.count
                        Text("Person Count: \(count)")
                    }
                }
                
            }

            ForEach(0..<adminVM.importYears.count) { _ in
                if let year = adminVM.importYears.last {
                   
                    Section(header: Text(String(year))) {
                    
                    }
                    
                }
                
    
                
            }
            
            VStack(alignment: .leading) {
                Section(header: Text("2020")) {
                    Text("Person Count: \(adminVM.persons2020.count)")
                    Text("Title Count: \(adminVM.titles2020.count)")
                    Text("Department Count: \(adminVM.departments2020.count)")
                    Text("Campus Count: \(adminVM.campuses2020.count)")


                }

                Section(header: Text("2019")) {
                    Text("Person Count: \(adminVM.persons2019.count)")
                    Text("Title Count: \(adminVM.titles2019.count)")
                    Text("Department Count: \(adminVM.departments2019.count)")
                    Text("Campus Count: \(adminVM.campuses2019.count)")


                }

                Section(header: Text("2018")) {
                    Text("Person Count: \(adminVM.persons2018.count)")
                    Text("Title Count: \(adminVM.titles2018.count)")
                    Text("Department Count: \(adminVM.departments2018.count)")
                    Text("Campus Count: \(adminVM.campuses2018.count)")


                }

                Section(header: Text("2017")) {
                    Text("Person Count: \(adminVM.persons2017.count)")
                    Text("Title Count: \(adminVM.titles2017.count)")
                    Text("Department Count: \(adminVM.departments2017.count)")
                    Text("Campus Count: \(adminVM.campuses2017.count)")


                }

                Section(header: Text("2016")) {
                    Text("Person Count: \(adminVM.persons2016.count)")
                    Text("Title Count: \(adminVM.titles2016.count)")
                    Text("Department Count: \(adminVM.departments2016.count)")
                    Text("Campus Count: \(adminVM.campuses2016.count)")


                }

                Section(header: Text("2015")) {
                    Text("Person Count: \(adminVM.persons2015.count)")
                    Text("Title Count: \(adminVM.titles2015.count)")
                    Text("Department Count: \(adminVM.departments2015.count)")
                    Text("Campus Count: \(adminVM.campuses2015.count)")


                }

                Section(header: Text("2014")) {
                    if let personCount = adminVM.allPersons[2014] {
                        let count = personCount.count
                        Text("Person Count: \(count)")
                    }

                    Text("Title Count: \(adminVM.titles2014.count)")
                    Text("Department Count: \(adminVM.departments2014.count)")
                    Text("Campus Count: \(adminVM.campuses2014.count)")


                }

                Section(header: Text("2013")) {

                    if let personCount = adminVM.allPersons[2013] {
                        let count = personCount.count
                        Text("Person Count: \(count)")
                    }


                    Text("Title Count: \(adminVM.titles2013.count)")
                    Text("Department Count: \(adminVM.departments2013.count)")
                    Text("Campus Count: \(adminVM.campuses2013.count)")


                }
                
            }
        }
        .onAppear(perform: {
            adminVM.loadAdminScreen()
        })
        
    }
    
}

struct DashboardCountsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCountsView()
    }
}
