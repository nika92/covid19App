//
//  TotalCases.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/8/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import Foundation

class TotalCases: NSObject {
    
    public var totalConfirmed = 0
    public var totalRecovered = 0
    public var totalDeaths    = 0
    
    public var isEmpty = true
    
    override init () {
        
    }
    
    init (dict: [String: Any]) {
        
        super.init()
        
        totalConfirmed  = dict["TotalConfirmed"] as! Int
        totalDeaths     = dict["TotalDeaths"] as! Int
        totalRecovered  = dict["TotalRecovered"] as! Int
        
        checkCase()
    }
    
    init (savedCase: Case) {
        
        super.init()
        
        self.totalConfirmed     = savedCase.totalConfirmed
        self.totalDeaths        = savedCase.totalDeaths
        self.totalRecovered     = savedCase.totalRecovered
        
        checkCase()
    }
    
    private func checkCase () {
        
        if self.totalConfirmed == 0 && self.totalRecovered == 0 && self.totalDeaths == 0 {
            isEmpty = true
        } else {
            isEmpty = false
        }
    }
}
