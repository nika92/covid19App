//
//  CustomNavC.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class CustomNavC: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.topItem?.title = "COVID 19"
        navigationBar.barTintColor   = StyleUtils.appColor(.background)
    }
}
