//
//  Popup.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/8/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class Popup: UIView {
    
    let reuseIndetifier = "Popup"
    static let shared   = Popup()
    
    @IBOutlet weak var titleLbl: UILabel!
    
    var isShown = false
    var popup: Popup!
    
    private var height = 80
    
    func show (message: String) {
        
        popup = (UINib(nibName: reuseIndetifier, bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! Popup)
        
        addObservers()
        styleView(popup: popup)
        popup.titleLbl.text = message
        
        window().addSubview(popup)
        showWithAnimation(popup: popup)
    }
    
    private func showWithAnimation (popup: Popup) {
         
        if isShown {
            hide()
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
           
            popup.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: self.height)
            
        }) { (isCompleted) in
            self.isShown = true
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.hide), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func hideWithAnimation (popup: Popup) {
        
        if !isShown {
            return
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            popup.frame = CGRect(x: 0, y: -100, width: Int(UIScreen.main.bounds.width), height: self.height)
        }) { (isCompleted) in
            popup.removeFromSuperview()
            self.isShown = false
        }
    }
    
    @objc func hide () {
        hideWithAnimation(popup: popup)
    }
    
    private func styleView (popup: Popup) {
        
        popup.frame = CGRect(x: 0, y: -100, width: Int(UIScreen.main.bounds.width), height: self.height)
        popup.backgroundColor       = StyleUtils.appGreyColor()
        popup.titleLbl.textColor    = StyleUtils.appBgColor()
        
        popup.setShadow()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        popup.addGestureRecognizer(tap)
    }
    
    private func addObservers () {
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func rotated() {
        
        if !isShown {
            return
        }
        
        if UIDevice.current.orientation.isLandscape {
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.popup.frame = CGRect(x: 0, y: -20, width: Int(UIScreen.main.bounds.width), height: self.height)
            }) { (isCompleted) in
            }
            
        } else {

            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.popup.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: self.height)
            }) { (isCompleted) in
            }
        }
        
//        self.hide()
    }
    
    private func window () -> UIWindow {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
    }
    
}
