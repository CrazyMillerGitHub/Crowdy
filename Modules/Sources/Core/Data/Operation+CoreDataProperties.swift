//
//  Operation+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension Operation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Operation> {
        return NSFetchRequest<Operation>(entityName: "Operation")
    }

    @NSManaged public var currencyId: UUID?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var id: UUID?
    @NSManaged public var userId: UUID?
    @NSManaged public var fundId: UUID?
    @NSManaged public var currency: Currency?
    @NSManaged public var fund: Fund?
    @NSManaged public var user: User?

}

extension Operation : Identifiable {

}
