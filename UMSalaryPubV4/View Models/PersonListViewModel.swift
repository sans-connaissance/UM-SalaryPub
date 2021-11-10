//
//  PersonListViewModel.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/8/21.
//

import Foundation
import CoreData




enum SortYear: Int64, CaseIterable {
    
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
    
    func getPersonsByYear() {
        
        let personViewModel: [Person] = Person.byYear(year: String(selectedSortYear.rawValue))
        
        persons = personViewModel.map(PersonViewModel.init)
    }
    

    
    

    
    
    
    func getAllByYear() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.fetchBatchSize = 20
        request.fetchLimit = 50
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
        DispatchQueue.main.async {
            self.persons = (self.fetchedResultsController.fetchedObjects ?? []).map(PersonViewModel.init)
        }
    }
}

extension PersonListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.persons = (controller.fetchedObjects as? [Person] ?? []).map(PersonViewModel.init)
    }
}
