//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData




enum SortYear: Int, CaseIterable {
    
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

class PersonListViewModel: NSObject, ObservableObject {
    
    // This is where I need to add all the filters and stuff I think
    
    @Published var persons = [PersonViewModel]()
    @Published var allPersons = [Int: [PersonViewModel]]()
    @Published var importYears = Person.importYears
    
    @Published var selectedSortYear: SortYear = .twenty
    
    private var fetchedResultsController: NSFetchedResultsController<Person>!
    
    //    func loadPersonView() {
    //        getAllByYear()
    //        extractByYear(year: 2020)
    //    }
    
    //    func getPersonsByYear() {
    //
    //        let personViewModel: [Person] = Person.byYear(year: String(selectedSortYear.rawValue))
    //
    //        persons = personViewModel.map(PersonViewModel.init)
    //    }
    
    func extractByYear(year: Int) -> [PersonViewModel] {
        var personArray = [PersonViewModel]()
        personArray = allPersons[year]!
        
        return personArray
    }
    
    func getPersonsByYear() {
        
        for year in importYears {
            let request: [Person] = Person.byYear(year: String(year))
            allPersons[year] = request.map(PersonViewModel.init)
        }
    }
    
    
    // do i need to pass in a year here?
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
