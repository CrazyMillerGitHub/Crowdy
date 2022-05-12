//
//  DetailfEffect.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

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
    let fakeArr: [FundDetail] = [.fake1, .fake2, .fake3]
    guard let fake = fakeArr.first(where: {$0.id == uuid }) else {
        return Effect(error: .decodingError)
            .eraseToEffect()
    }
    return Effect(value: fake)
    .eraseToEffect()
}

private func getInfo() -> String {
    return "**Описание задачи**"
}

#endif
