//
//  PersonDAO.swift
//  salarySlowBuild-v3 (iOS)
//
//  Created by David Malicke on 1/2/21.
//

import Foundation
import CoreData

class PersonDAO: BaseDAO {
    
    // Singleton object
    static let shared = PersonDAO()
    
    private let personEntityName = "Person"
    
    func addPersonsIfNeeded() {
        guard !hasRecords() else {
            return
        }
        
        if let persons = AppUtils.dictionaryFromFile(name: "csvjson-02016")["persons"] as? [[String: Any]] {
            for person in persons {
                
                var campus: Campus?
                if let campusName = person["campus"] as? String {
                    if let campusYear = person["year"] as? Int64 {
                        if let campusAverageAnnual = person["campusAverageAnnual"] as? Double {
                            if let campusMedianAnnual = person["campusMedianAnnual"] as? Double {
                                if let campusMaxAnnual = person["campusMaxAnnual"] as? Double {
                                    if let campusMinAnnual = person["campusMinAnnual"] as? Double {
                                        if let campusCount = person["campusCount"] as? Double {
                                            if let campusAnnArborAverage = person["campusAnnArborAverage"] as? Double {
                                                if let campusDearbornAverage = person["campusDearbornAverage"] as? Double {
                                                    if let campusFlintAverage = person["campusFlintAverage"] as? Double {
                                            
                                            
                                            
                                            
                                            
                                            campus = CampusDAO.shared.saveCampusIfNeeded(campusName: campusName,
                                                                                         campusYear: campusYear,
                                                                                         campusAverageAnnual: campusAverageAnnual,
                                                                                         campusMedianAnnual: campusMedianAnnual,
                                                                                         campusMaxAnnual: campusMaxAnnual,
                                                                                        campusMinAnnual: campusMinAnnual,
                                                                                        campusAnnArborAverage: campusAnnArborAverage,
                                                                                        campusDearbornAverage: campusDearbornAverage,
                                                                                        campusFlintAverage: campusFlintAverage,
                                                                                        campusCount: campusCount)
                                                    
                                                    
                                                    
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                
                
                
                var department: Department?
                if let departmentName = person["appointmentDepartment"] as? String {
                    if let departmentYear = person["year"] as? Int64 {
                        if let departmentAverageAnnual = person["departmentAverageAnnual"] as? Double {
                            
                            if let departmentMedianAnnual = person["departmentMedianAnnual"] as? Double {
                                
                                if let departmentMaxAnnual = person["departmentMaxAnnual"] as? Double {
                                    
                                    if let departmentMinAnnual = person["departmentMinAnnual"] as? Double {
                                        
                                        if let departmentCount = person["departmentCount"] as? Double {
                                            
                                            
                                            
                                            
                                            
                                            department = DepartmentDAO.shared.saveDepartmentIfNeeded(departmentName: departmentName,
                                                                                                     departmentYear: departmentYear,
                                                                                                     departmentAverageAnnual: departmentAverageAnnual,
                                                                                                     
                                                                                                     departmentMedianAnnual: departmentMedianAnnual,
                                                                                                     
                                                                                                     departmentMaxAnnual: departmentMaxAnnual,
                                                                                                     
                                                                                                     departmentMinAnnual: departmentMinAnnual,
                                                                                                     
                                                                                                     departmentCount: departmentCount)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                var title: Title?
                if let titleName = person["appointmentTitle"] as? String {
                    if let titleYear = person["year"] as? Int64 {
                        if let titleAverageAnnual = person["titleAverageAnnual"] as? Double {
                            if let titleMedianAnnual = person["titleMedianAnnual"] as? Double {
                                if let titleMaxAnnual = person["titleMaxAnnual"] as? Double {
                                    if let titleMinAnnual = person["titleMinAnnual"] as? Double {
                                        if let titleCount = person["titleCount"] as? Double {
                                            if let titleAnnArborAverage = person["titleAnnArborAverage"] as? Double {
                                                if let titleDearbornAverage = person["titleDearbornAverage"] as? Double {
                                                    if let titleFlintAverage = person["titleFlintAverage"] as? Double {
                                            
                                            
                                            title = TitleDAO.shared.saveTitleIfNeeded(titleName: titleName,
                                                                                      titleYear: titleYear,
                                                                                      titleAverageAnnual: titleAverageAnnual,
                                                                                      titleMedianAnnual: titleMedianAnnual,
                                                                                      titleMaxAnnual: titleMaxAnnual,
                                                                                      titleMinAnnual: titleMinAnnual,
                                                                                      titleAnnArborAverage: titleAnnArborAverage,
                                                                                      titleDearbornAverage: titleDearbornAverage,
                                                                                      titleFlintAverage: titleFlintAverage,
                                                                                      titleCount: titleCount)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                let newPerson = Person(context: managedContext)
                newPerson.amtSalaryFromGeneralFund = person["amtSalaryFromGeneralFund"] as? Double ?? 0
                newPerson.apptAnnualFTR = person["apptAnnualFTR"] as? Double ?? 0
                newPerson.apptFraction = person["apptFraction"] as? Double ?? 0
                newPerson.apptFTRBasis = person["apptFTRBasis"] as? String
                newPerson.fullName = person["fullName"] as? String
                newPerson.year = person["year"] as? Int64 ?? 0
                
                newPerson.campus = campus
                newPerson.department = department
                newPerson.title = title
                
                
            }
            CoreDataManager.shared.saveContext()
        }
    }
    
    func hasRecords() -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: personEntityName)
        var count = 0
        do {
            count = try managedContext.count(for: fetchRequest)
        } catch let error as NSError {
            print("Could not count. \(error)")
        }
        
//                        return count != 0
        return count == 1
    }
}
