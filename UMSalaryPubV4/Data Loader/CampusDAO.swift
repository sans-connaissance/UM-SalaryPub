//
//  CampusDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//  Adapted from an example created by user intelcy on fiverr.com to assist with loading data from JSON files into CoreData persistentContainer
//

import CoreData
import Foundation

class CampusDAO: BaseDAO {
    static let shared = CampusDAO()
    private let campusEntityName = "Campus"
    
    func saveCampusIfNeeded(campusName: String,
                            campusYear: Int64,
                            campusAverageAnnual: Double,
                            campusMedianAnnual: Double,
                            campusMaxAnnual: Double,
                            campusMinAnnual: Double,
                            campusAnnArborAverage: Double,
                            campusDearbornAverage: Double,
                            campusFlintAverage: Double,
                            campusCount: Double,
                            importYear: Int) -> Campus
    {
        ///Ensures that only unique campus records for each year are saved.
        ///This section was written by David Malicke.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: campusEntityName)
        let importYear = importYear
        let yearPredicate = NSPredicate(format: "campusYear = %i", importYear)
        let campusNamePredicate = NSPredicate(format: "campusName = %@", campusName)
        let combinedTitlePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, campusNamePredicate])
        fetchRequest.predicate = combinedTitlePredicate
        var campus: Campus?
        
        do {
            campus = (try managedContext.fetch(fetchRequest) as! [Campus]).first
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        guard campus == nil else {
            return campus!
        }

        let newCampus = Campus(context: managedContext)
        newCampus.campusName = campusName
        newCampus.campusYear = campusYear
        newCampus.campusAverageAnnual = campusAverageAnnual
        newCampus.campusMedianAnnual = campusMedianAnnual
        newCampus.campusMaxAnnual = campusMaxAnnual
        newCampus.campusMinAnnual = campusMinAnnual
        newCampus.campusCount = campusCount
        newCampus.campusAnnArborAverage = campusAnnArborAverage
        newCampus.campusDearbornAverage = campusDearbornAverage
        newCampus.campusFlintAverage = campusFlintAverage
        return newCampus
    }
}
