//
//  SavedCase+CoreDataProperties.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedCase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedCase> {
        return NSFetchRequest<SavedCase>(entityName: "SavedCase")
    }

    @NSManaged public var country: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var date: String?
    @NSManaged public var newConfirmed: Int16
    @NSManaged public var newDeaths: Int16
    @NSManaged public var newRecovered: Int16
    @NSManaged public var slug: String?
    @NSManaged public var totalConfirmed: Int64
    @NSManaged public var totalDeaths: Int64
    @NSManaged public var totalRecovered: Int64

}
