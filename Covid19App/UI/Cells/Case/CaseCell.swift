//
//  Case.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/8/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class CaseCell: UITableViewCell {
    
    static let reuseIdentifier = "CaseCell"
    
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var recoveredLbl: UILabel!
    @IBOutlet weak var deathLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleView()
    }
    
    private func styleView () {
        
        backgroundColor = .clear
        
        totalLbl.textColor      = StyleUtils.appGreenColor()
        recoveredLbl.textColor  = StyleUtils.appBlueColor()
        deathLbl.textColor      = StyleUtils.appRedColor()
    }
    
    public func setupWithCase (_case: Case) {
        
        countryLbl.text     = _case.country
        totalLbl.text       = String(_case.totalConfirmed)
        recoveredLbl.text   = String(_case.totalRecovered)
        deathLbl.text       = String(_case.totalDeaths)
    }
    
}
