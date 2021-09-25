//
//  Games+CoreDataProperties.swift
//  
//
//  Created by Mac on 25/09/21.
//
//

import Foundation
import CoreData


extension Games {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Games> {
        return NSFetchRequest<Games>(entityName: "Games")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var score: Int64
    @NSManaged public var rating: NSSet?

}

// MARK: Generated accessors for rating
extension Games {

    @objc(addRatingObject:)
    @NSManaged public func addToRating(_ value: Ratings)

    @objc(removeRatingObject:)
    @NSManaged public func removeFromRating(_ value: Ratings)

    @objc(addRating:)
    @NSManaged public func addToRating(_ values: NSSet)

    @objc(removeRating:)
    @NSManaged public func removeFromRating(_ values: NSSet)

}
