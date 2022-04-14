//
//  AddEffect.swift
//  
//
//  Created by Mikhail Borisov on 22.03.2022.
//

import Foundation
import ComposableArchitecture
import Core

public struct FundRequestDTO: Codable {}

public func createFundRequest(decoder: JSONDecoder, request: FundRequestDTO) -> Effect<FundRequestDTO, APIError> {
    return Effect(value: request)
}

public func saveFundRequest(storage: PersistenceController, request: FundRequestDTO) -> Effect<FundRequestDTO, StorageError> {
    storage.saveFund(dto: .fixture)
    return Effect(value: request)
}
