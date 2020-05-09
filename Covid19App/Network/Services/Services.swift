//
//  Services.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import Foundation

class Services {
    
    static let baseUrl = "https://api.covid19api.com/"
    
    static func getAllCases (completionHandler: @escaping (Data) -> (Void), errorHandler: @escaping (String) -> (Void)) {

        let semaphore = DispatchSemaphore (value: 0)

        let urlString       = baseUrl + "summary"
        var request         = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod  = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
//                print(String(describing: error))
                errorHandler(String(describing: error))
                return
            }
            
            completionHandler(data)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    static func getTotalGlobalCases (completionHandler: @escaping (Data) -> (Void), errorHandler: @escaping (String) -> (Void)) {

        let semaphore = DispatchSemaphore (value: 0)

        let urlString       = baseUrl + "world/total"
        var request         = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod  = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                errorHandler(String(describing: error))
                return
            }

            completionHandler(data)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
