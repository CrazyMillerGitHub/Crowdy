//
//  EditProfileEffect.swift
//  
//
//  Created by Mikhail Borisov on 04.05.2022.
//

import Foundation
import ComposableArchitecture
import Core

public func dummyEditProfileRequest(storage: PersistenceController) -> Effect<EditProfileDTO, StorageError> {
    return Effect(value: EditProfileDTO(fullName: storage.user.fullName, email: storage.user.email))
}
