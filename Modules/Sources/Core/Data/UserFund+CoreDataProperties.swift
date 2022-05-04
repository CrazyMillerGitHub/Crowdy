//
//  UserFund+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension UserFund {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserFund> {
        return NSFetchRequest<UserFund>(entityName: "UserFund")
    }

    @NSManaged public var favorite: Bool

}
