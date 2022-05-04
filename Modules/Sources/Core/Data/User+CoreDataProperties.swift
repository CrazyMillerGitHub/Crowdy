//
//  User+CoreDataProperties.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 24.04.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var fullName: String?
    @NSManaged public var email: String?
    @NSManaged public var operations: NSOrderedSet?
    @NSManaged public var ownedFunds: Fund?

}

// MARK: Generated accessors for operations
extension User {

    @objc(insertObject:inOperationsAtIndex:)
    @NSManaged public func insertIntoOperations(_ value: Operation, at idx: Int)

    @objc(removeObjectFromOperationsAtIndex:)
    @NSManaged public func removeFromOperations(at idx: Int)

    @objc(insertOperations:atIndexes:)
    @NSManaged public func insertIntoOperations(_ values: [Operation], at indexes: NSIndexSet)

    @objc(removeOperationsAtIndexes:)
    @NSManaged public func removeFromOperations(at indexes: NSIndexSet)

    @objc(replaceObjectInOperationsAtIndex:withObject:)
    @NSManaged public func replaceOperations(at idx: Int, with value: Operation)

    @objc(replaceOperationsAtIndexes:withOperations:)
    @NSManaged public func replaceOperations(at indexes: NSIndexSet, with values: [Operation])

    @objc(addOperationsObject:)
    @NSManaged public func addToOperations(_ value: Operation)

    @objc(removeOperationsObject:)
    @NSManaged public func removeFromOperations(_ value: Operation)

    @objc(addOperations:)
    @NSManaged public func addToOperations(_ values: NSOrderedSet)

    @objc(removeOperations:)
    @NSManaged public func removeFromOperations(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
