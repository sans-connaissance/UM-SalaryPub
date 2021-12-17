//
//  CampusDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
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
