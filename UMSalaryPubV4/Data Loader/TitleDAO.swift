//
//  TitleDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
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
