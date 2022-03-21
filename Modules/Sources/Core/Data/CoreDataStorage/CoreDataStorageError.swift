//
//  CoreDataStorageError.swift
//  
//
//  Created by Mikhail Borisov on 21.03.2022.
//

import Foundation

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}
