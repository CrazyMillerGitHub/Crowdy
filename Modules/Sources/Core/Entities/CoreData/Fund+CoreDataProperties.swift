//
//  Fund+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 03.04.2022.
//
//

import Foundation
import CoreData


extension Fund {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fund> {
        return NSFetchRequest<Fund>(entityName: "Fund")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?
    @NSManaged public var amountPrecentage: Double
    @NSManaged public var expirationDate: Double
    @NSManaged public var participants: Int64
    @NSManaged public var status: Int16

}

extension Fund : Identifiable {

}
