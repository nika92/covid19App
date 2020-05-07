//
//  Extensions.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import Foundation

extension Data {
    
    func toDictionary () -> [String: Any]? {
        
        let dataStr = String(data: self, encoding: .utf8)!
        
        if let data = dataStr.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
