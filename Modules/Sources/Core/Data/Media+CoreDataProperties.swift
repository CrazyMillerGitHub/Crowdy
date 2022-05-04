//
//  Media+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var data: Data?
    @NSManaged public var background: Bool
    @NSManaged public var fund: Fund?
    @NSManaged public var detail: Detail?

}

extension Media : Identifiable {

}
