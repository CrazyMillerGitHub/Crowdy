//
//  Fund+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension Fund {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fund> {
        return NSFetchRequest<Fund>(entityName: "Fund")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var type: Int16
    @NSManaged public var status: Int16
    @NSManaged public var expirationDate: Date?
    @NSManaged public var originalAmount: NSDecimalNumber?
    @NSManaged public var remainAmount: NSDecimalNumber?
    @NSManaged public var currency: Currency?
    @NSManaged public var operations: Operation?
    @NSManaged public var placeholderMedia: Media?
    @NSManaged public var creator: User?

}

extension Fund : Identifiable {

}
