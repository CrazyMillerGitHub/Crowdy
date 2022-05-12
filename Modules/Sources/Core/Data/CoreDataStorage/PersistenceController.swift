//
//  CoreDataStorage.swift
//  
//
//  Created by Mikhail Borisov on 21.03.2022.
//

#if !APPCLIP

import CoreData

public struct PersistenceController {

    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    public let container: NSPersistentContainer

    public var user: UserDTO = .fixture

    // A test configuration for SwiftUI previews
    static public var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()

    public mutating func update(user: UserDTO) {
        self.user = user
    }

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    public init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "CoreDataStorage")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    public func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}

extension PersistenceController {

}

#endif
