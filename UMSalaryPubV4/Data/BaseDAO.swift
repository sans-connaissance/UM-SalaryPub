//
//  BaseDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//

import Foundation
import CoreData

class BaseDAO {
    
    let managedContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
}
