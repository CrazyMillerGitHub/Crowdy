//
//  CoreDataStorageError.swift
//  
//
//  Created by Mikhail Borisov on 21.03.2022.
//

import Foundation

#if !APPCLIP

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

#endif
