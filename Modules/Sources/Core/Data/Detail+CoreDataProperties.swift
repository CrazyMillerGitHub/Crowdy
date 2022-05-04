//
//  Detail+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var previewImageId: UUID?
    @NSManaged public var info: String?
    @NSManaged public var previews: Media?

}
