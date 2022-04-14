//
//  DetailfEffect.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import Foundation
import ComposableArchitecture
import Core

func loadDetailRequest(decoder: JSONDecoder, baseURL: URL, uuid: UUID) -> Effect<FundDetail, APIError> {
    return URLSession.shared.dataTaskPublisher(for: baseURL.appendingPathComponent(uuid.description))
        .mapError { _ in APIError.downloadError }
        .map(\.data)
        .decode(type: FundDetail.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

public func dummyLoadDetailRequest(decoder: JSONDecoder, baseURL: URL, uuid: UUID) -> Effect<FundDetail, APIError> {
    let progressModel = Progress(
        remainAmount: .init(amount: 1000, currency: "ru_RU"),
        originalAmount: .init(amount: 2000, currency: "ru_RU")
    )
    return Effect(value: .init(
        id: .init(),
        fund: .fixture,
        title: "Лучший сбор в мире",
        author: "Mikhail Borisov",
        info: getInfo(),
        isIncoming: true,
        progress: progressModel
    )
    )
    .delay(for: 1, scheduler: DispatchQueue.main)
    .eraseToEffect()
}

private func getInfo() -> String {
    return "**Описание задачи**"
}
