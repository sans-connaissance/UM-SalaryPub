//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData




enum FetchYear: Int, CaseIterable {
    
    case twenty = 2020
    case nineteen = 2019
    
    var displayText: String {
        
        switch self {
        case .twenty:
            return "2020"
        case .nineteen:
            return "2019"
            
        }
    }
}

enum MoneySort: CaseIterable {
    
    case most
    case least
    
    var value: Bool {
        switch self {
        case .most:
            return true
        case .least:
            return false
        }
    }
    
    var displayText: String {
        switch self {
        case .most:
            return "$$$"
        case .least:
            return "$"
        }
    }
}





class PersonListViewModel: NSObject, ObservableObject {
    

    
    @Published var allPersons = [Int: [PersonViewModel]]()
    @Published var importYears = Person.importYears
    @Published var selectedSortYear: FetchYear = .twenty
    @Published var moneySort: MoneySort = .most
    @Published var alphabetSort = false

    
    private var fetchedResultsController: NSFetchedResultsController<Person>!
    

    
    
    func getPersonsByYear() {
        
        for year in importYears {
            let request: [Person] = Person.byYear(year: String(year), moneySort: moneySort.value, alphabetSort: alphabetSort)
            allPersons[year] = request.map(PersonViewModel.init)
        }
    }
    
    
    func getAllByYear() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.fetchBatchSize = 20
        request.fetchLimit = 50
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
        for year in importYears {
            DispatchQueue.main.async {
                self.allPersons[year] = (self.fetchedResultsController.fetchedObjects ?? []).map(PersonViewModel.init)
            }
        }
    }
}

extension PersonListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        for year in importYears {
            self.allPersons[year] = (controller.fetchedObjects as? [Person] ?? []).map(PersonViewModel.init)
        }
    }
}
