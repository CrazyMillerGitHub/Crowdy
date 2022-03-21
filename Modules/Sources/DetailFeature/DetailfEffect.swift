//
//  DetailfEffect.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import Foundation
import ComposableArchitecture
import Core

func loadDetailsRequest(decoder: JSONDecoder, uuid: UUID) -> Effect<DetailModel, APIError> {
    guard let url = URL(string: "test.com") else {
        return .init(error: .urlError)
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map(\.data)
        .decode(type: DetailModel.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

public func dummyLoadDetailsRequest(decoder: JSONDecoder, uuid: UUID) -> Effect<DetailModel, APIError> {
    let progressModel = ProgressModel(
        remainAmount: .init(amount: 10, currency: "ru_RU"),
        originalAmount: .init(amount: 20, currency: "ru_RU")
    )
    return Effect(value: .init(
        id: .init(),
        fund: .fixture,
        title: "Лучший сбор в мире",
        author: "Mikhail Borisov",
        info: "No info",
        isIncoming: false,
        progress: progressModel)
    )
    .delay(for: 2, scheduler: RunLoop.main)
    .eraseToEffect()
}
