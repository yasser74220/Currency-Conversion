//
//  FavoriteList+CoreDataProperties.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 25/08/2023.
//
//

import Foundation
import CoreData


extension FavoriteList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteList> {
        return NSFetchRequest<FavoriteList>(entityName: "FavoriteList")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var currencyName: String?
    @NSManaged public var currencyCode: String?

}

extension FavoriteList : Identifiable {

}
