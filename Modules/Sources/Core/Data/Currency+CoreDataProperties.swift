//
//  Currency+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var code: String?
    @NSManaged public var operations: Operation?
    @NSManaged public var funds: Fund?

}

extension Currency : Identifiable {

}
