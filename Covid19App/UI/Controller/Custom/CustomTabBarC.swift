//
//  CustomTabBarC.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/8/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class CustomTabBarC: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.backgroundColor = StyleUtils.appBgColor()
    }
}
