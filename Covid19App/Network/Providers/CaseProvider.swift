//
//  CountryProvider.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import Foundation
import CoreData

class CaseProvider {
    
    static let shared = CaseProvider()
    
    public var cases: Array<Case>!
    
    public func getAllCases (completionHandler: @escaping (Array<Case>) -> (Void), errorHandler: @escaping (String) -> (Void)) {
        
        if cases != nil {
            completionHandler(cases)
            return
        }
        
        cases = Array<Case>()
        Services.getAllCases(completionHandler: {(response) -> (Void) in
            
            self.clearData()
            let array: Array = response.toDictionary()!["Countries"] as! Array<Any>
            
            for cs in array {
                
                let _case = Case.init(dict: cs as! [String : Any])
                self.cases.append(_case)
                
                _case.save()
            }
            
            completionHandler(self.cases)
            
        }, errorHandler: {(error) -> (Void) in
            errorHandler(error)
        })
    }
    
    public func getSavedCases () -> Array<Case> {
        
        var cases = Array<Case>()
        
        let fetchRequest: NSFetchRequest<SavedCase> = SavedCase.fetchRequest()
        do {
            let savedCases = try PersistenceManager.context.fetch(fetchRequest)
            
            for cs in savedCases {
                
                let _case:Case = Case.init(savedCase: cs)
                cases.append(_case)
            }
            return cases
            
        } catch {
            return cases
        }
    }
    
    public func getCaseByKeyword (keyword: String) -> Array<Case> {
        
        var result = Array<Case>()
        
        for cs in cases {
            if cs.country.range(of: keyword, options: .caseInsensitive) != nil {
                result.append(cs)
            }
        }
        
        return result
    }
    
    private func clearData () {
        
        let entity = "SavedCase"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try PersistenceManager.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                PersistenceManager.context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
}
