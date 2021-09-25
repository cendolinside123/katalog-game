//
//  Ratings+CoreDataProperties.swift
//  
//
//  Created by Mac on 25/09/21.
//
//

import Foundation
import CoreData


extension Ratings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ratings> {
        return NSFetchRequest<Ratings>(entityName: "Ratings")
    }

    @NSManaged public var count: Double
    @NSManaged public var id: Int16
    @NSManaged public var percent: Double
    @NSManaged public var title: String?
    @NSManaged public var game: Games?

}
