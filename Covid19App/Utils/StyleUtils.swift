//
//  StyleUtils.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

enum AssetsColor : String {
    case background
    case title
}

enum AssetsImage : String {
    case search
    case heart
    case checkmark
}

class StyleUtils {
    
    static func appColor (_ name: AssetsColor) -> UIColor? {
       return UIColor(named: name.rawValue)
    }
    
    static func appImage (_ name: AssetsImage) -> UIImage? {
        return UIImage(named: name.rawValue)
    }
    
    static func appBgColor (alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(237.0/255.0), green: CGFloat(242.0/255.0), blue: CGFloat(243.0/255.0), alpha: alpha!)
    }
    
    static func appGreenColor (alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(67.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(113.0/255.0), alpha: alpha!)
    }
    
    static func appBlueColor (alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(116.0/255.0), green: CGFloat(175.0/255.0), blue: CGFloat(255.0/255.0), alpha: alpha!)
    }
    
    static func appRedColor (alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(244.0/255.0), green: CGFloat(73.0/255.0), blue: CGFloat(73.0/255.0), alpha: alpha!)
    }
    
    static func appGreyColor (alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(58.0/255.0), green: CGFloat(64.0/255.0), blue: CGFloat(71.0/255.0), alpha: alpha!)
    }
    
}
