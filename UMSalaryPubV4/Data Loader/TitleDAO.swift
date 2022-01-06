//
//  TitleDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//  Adapted from an example created by user intelcy on fiverr.com to assist with loading data from JSON files into CoreData persistentContainer
//

import CoreData
import Foundation

class TitleDAO: BaseDAO {
    static let shared = TitleDAO()
    private let titleEntityName = "Title"
    
    func saveTitleIfNeeded(titleName: String,
                           titleYear: Int64,
                           titleAverageAnnual: Double,
                           titleMedianAnnual: Double,
                           titleMaxAnnual: Double,
                           titleMinAnnual: Double,
                           titleAnnArborAverage: Double,
                           titleDearbornAverage: Double,
                           titleFlintAverage: Double,
                           titleCount: Double,
                           importYear: Int) -> Title
    {
        ///Ensures that only unique title records for each year are saved.
        ///This section was written by David Malicke.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: titleEntityName)
        let importYear = importYear
        let yearPredicate = NSPredicate(format: "titleYear = %i", importYear)
        let titleNamePredicate = NSPredicate(format: "titleName = %@", titleName)
        let combinedTitlePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, titleNamePredicate])
        fetchRequest.predicate = combinedTitlePredicate
        
        var title: Title?
        do {
            title = (try managedContext.fetch(fetchRequest) as! [Title]).first
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        guard title == nil else {
            return title!
        }

        let newTitle = Title(context: managedContext)
        newTitle.titleYear = titleYear
        newTitle.titleName = titleName
        newTitle.titleAverageAnnual = titleAverageAnnual
        newTitle.titleMedianAnnual = titleMedianAnnual
        newTitle.titleMaxAnnual = titleMaxAnnual
        newTitle.titleMinAnnual = titleMinAnnual
        newTitle.titleCount = titleCount
        newTitle.titleAnnArborAverage = titleAnnArborAverage
        newTitle.titleDearbornAverage = titleDearbornAverage
        newTitle.titleFlintAverage = titleFlintAverage
        return newTitle
    }
}
