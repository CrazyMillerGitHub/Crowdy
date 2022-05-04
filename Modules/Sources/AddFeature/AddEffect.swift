//
//  AddEffect.swift
//  
//
//  Created by Mikhail Borisov on 22.03.2022.
//

#if !APPCLIP

import Foundation
import ComposableArchitecture
import Core

public struct FundRequestDTO: Codable {

    var id: UUID

    var title: String

    var info: String?

    var expirationDate: Double

    var creatorId: Int

    var category: Int
}

public func createFundRequest(decoder: JSONDecoder, request: FundRequestDTO) -> Effect<FundRequestDTO, APIError> {
    return Effect(value: request)
}

public func saveFundRequest(storage: PersistenceController, request: FundRequestDTO) -> Effect<FundRequestDTO, StorageError> {
//    let userFund = UserFund(context: storage.container.viewContext)
//    userFund.id = request.id
//    userFund.title = request.title
//    storage.save()
    return Effect(error: .unknown)
}

#endif
