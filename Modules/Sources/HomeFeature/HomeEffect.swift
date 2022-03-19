//
//  HomeEffect.swift
//  
//
//  Created by Mikhail Borisov on 10.01.2022.
//

import Foundation
import ComposableArchitecture
import Core

func loadFundsRequest(decoder: JSONDecoder) -> Effect<[Fund], APIError> {
	guard let url = URL(string: "es.com/apo") else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: [Fund].self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

struct EditFavoriteResponse: Decodable {

    let success: Bool
}

func editFavorite(decoder: JSONDecoder, identifier: UUID) -> Effect<EditFavoriteResponse, APIError> {
    return Effect(value: .init(success: true))
}

public func dummyLoadFundsRequest(decoder: JSONDecoder) -> Effect<[Fund], APIError> {
    return Effect(value: [.init(), .init(), .init()])
        .delay(for: 2, scheduler: RunLoop.main)
        .eraseToEffect()
}
