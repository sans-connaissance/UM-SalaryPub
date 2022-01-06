/// This class was written by user intelcy on fiverr.com to assist with loading data from JSON files into CoreData persistentContainer

import CoreData
import Foundation

class BaseDAO {
    let managedContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
}
