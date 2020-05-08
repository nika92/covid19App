//
//  Case.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import Foundation

class Case: NSObject {
    
    public var country          = ""
    public var countryCode      = ""
    public var date             = ""
    public var newConfirmed     = 0
    public var newDeaths        = 0
    public var newRecovered     = 0
    public var slug             = ""
    public var totalConfirmed   = 0
    public var totalDeaths      = 0
    public var totalRecovered   = 0
    
    override init () {
        
    }
    
    init (dict: [String: Any]) {
        
        country         = dict["Country"] as! String
        countryCode     = dict["CountryCode"] as! String
        date            = dict["Date"] as! String
        newConfirmed    = dict["NewConfirmed"] as! Int
        newDeaths       = dict["NewDeaths"] as! Int
        newRecovered    = dict["NewRecovered"] as! Int
        slug            = dict["Slug"] as! String
        totalConfirmed  = dict["TotalConfirmed"] as! Int
        totalDeaths     = dict["TotalDeaths"] as! Int
        totalRecovered  = dict["TotalRecovered"] as! Int
    }
    
    init (savedCase: SavedCase) {
        
        self.country            = savedCase.country!
        self.countryCode        = savedCase.countryCode!
        self.date               = savedCase.date!
        self.newConfirmed       = Int(savedCase.newConfirmed)
        self.newDeaths          = Int(savedCase.newDeaths)
        self.newRecovered       = Int(savedCase.newRecovered)
        self.slug               = savedCase.slug!
        self.totalConfirmed     = Int(savedCase.totalConfirmed)
        self.totalDeaths        = Int(savedCase.totalDeaths)
        self.totalRecovered     = Int(savedCase.totalRecovered)
    }
    
    func save () {
        
        let savedCase = SavedCase(context: PersistenceManager.context)
        
        savedCase.country           = self.country
        savedCase.countryCode       = self.countryCode
        savedCase.date              = self.date
        savedCase.newConfirmed      = Int16(self.newConfirmed)
        savedCase.newDeaths         = Int16(self.newDeaths)
        savedCase.newRecovered      = Int16(self.newRecovered)
        savedCase.slug              = self.slug
        savedCase.totalConfirmed    = Int64(self.totalConfirmed)
        savedCase.totalDeaths       = Int64(self.totalDeaths)
        savedCase.totalRecovered    = Int64(self.totalRecovered)
        
        PersistenceManager.saveContext()
    }
}
