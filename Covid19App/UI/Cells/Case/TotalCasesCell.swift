//
//  TotalCasesCell.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/8/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class TotalCasesCell: UITableViewCell {
    
    static let reuseIdentifier = "TotalCasesCell"
    
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var recoveredView: UIView!
    @IBOutlet weak var deathsView: UIView!
    @IBOutlet weak var percentageLbl: UILabel!
    
    @IBOutlet weak var totalConfirmedLbl: UILabel!
    @IBOutlet weak var totalRecoveredLbl: UILabel!
    @IBOutlet weak var totalDeathsLbl: UILabel!
    
    @IBOutlet weak var totalConfirmedImgView: UIImageView!
    @IBOutlet weak var totalRecoveredImgView: UIImageView!
    @IBOutlet weak var totalDeathsImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleView()
    }
    
    private func styleView () {
        
        backgroundColor = .clear
        
        confirmedView.backgroundColor = StyleUtils.appGreyColor()
        recoveredView.backgroundColor = StyleUtils.appGreyColor()
        deathsView.backgroundColor    = StyleUtils.appGreyColor()
        
        totalConfirmedLbl.textColor = StyleUtils.appGreenColor()
        totalRecoveredLbl.textColor = StyleUtils.appBlueColor()
        totalDeathsLbl.textColor    = StyleUtils.appRedColor()
        percentageLbl.textColor     = StyleUtils.appGreyColor()
        
        totalConfirmedImgView.image = UIImage(named: "checkmark_icon")?.imageWithColor(color1: StyleUtils.appGreenColor())
        totalRecoveredImgView.image = UIImage(named: "heart_icon")?.imageWithColor(color1: StyleUtils.appBlueColor())
        totalDeathsImgView.image = UIImage(named: "heart_icon")?.imageWithColor(color1: StyleUtils.appRedColor())
        
        confirmedView.layer.cornerRadius = 5
        recoveredView.layer.cornerRadius = 5
        deathsView.layer.cornerRadius    = 5
    }
    
    func setupWithTotalCases (totalCases: TotalCases) {
        
        if totalCases.isEmpty {
            return
        }
        
        totalConfirmedLbl.text = String(totalCases.totalConfirmed)
        totalRecoveredLbl.text = String(totalCases.totalRecovered)
        totalDeathsLbl.text    = String(totalCases.totalDeaths)
        
        let percent = totalCases.totalRecovered * 100 / totalCases.totalConfirmed
        percentageLbl.text = "RECOVERED " + String(percent) + "%"
    }
}
