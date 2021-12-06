//
//  BaseDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//

import CoreData
import Foundation

class BaseDAO {
    let managedContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
}
