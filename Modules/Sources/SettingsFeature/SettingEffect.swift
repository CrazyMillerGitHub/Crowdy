//
//  SettingEffect.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import Core
import OperationRow
import ComposableArchitecture
import Foundation

public func dummyLoadUserOperationsRequest(decoder: JSONDecoder, encoder: JSONEncoder, baseURL: URL) -> Effect<[OperationModel], APIError> {
    return Effect(value: [.fixture])
        .delay(for: 0.5, scheduler: DispatchQueue.main)
        .eraseToEffect()
}

public func dummyLoadUserRequest(storage: CoreDataStorage) -> Effect<User, StorageError> {
    return Effect(value: .fixture)
        .delay(for: 0.5, scheduler: DispatchQueue.main)
        .eraseToEffect()
}
