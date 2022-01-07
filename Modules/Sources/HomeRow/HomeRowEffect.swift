//
//  HomeRowEffect.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import Core
import Combine
import ComposableArchitecture
import Foundation
import UIKit

func crowdfundingEffect(
	decoder: JSONDecoder,
	crowdfundingId: Int
) -> Effect<HomeRowModel, APIError> {
	guard let url = URL(string: "test.api.com/crowdfunding/id=\(crowdfundingId)") else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: HomeRowModel.self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func dummyCrowdfundingEffect(
	decoder: JSONDecoder,
	crowdfundingId: Int
) -> Effect<HomeRowModel, APIError> {
	let url = URL(fileURLWithPath: "")
	let response = HomeRowModel(
		identifier: .init(),
		title: "Крутой стол в каждый дом",
		subtitle: "Пустое описание",
		mediaUrl: url,
		favourite: true,
		expirationDate: 10,
		originalAmount: 15,
		remainAmount: 5,
		participantsCount: 1434
	)
	return Effect(value: response)
}

func mediaContentEffect(decoder: JSONDecoder, url: URL?) -> Effect<UIImage, APIError> {
	guard let url = url else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.tryMap { data in
			guard let image = UIImage(data: data) else { throw APIError.decodingError }
			return image
		}
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func dummyMediaContentEffect(decoder: JSONDecoder, url: URL?) -> Effect<UIImage, APIError> {
	guard let image = UIImage(systemName: "circle") else {
		assertionFailure("Данный блок не должен падать с ошибкой")
		return Effect(error: .downloadError)
	}
	return Effect(value: image)
}

func updateFavouriteEffect(
	decoder: JSONDecoder,
	crowdfundingId: Int,
	newState: Bool
) -> Effect<HomeRowModel, APIError> {
	guard let url = URL(string: "test.api.com/crowdfunding/id=\(crowdfundingId)") else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: HomeRowModel.self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func dummyUpdateFavouriteEffect(
	decoder: JSONDecoder,
	crowdfundingId: Int,
	newState: Bool
)-> Effect<HomeRowModel, APIError> {
	let url = URL(fileURLWithPath: "")
	let response = HomeRowModel(
		identifier: .init(),
		title: "Крутой стол в каждый дом",
		subtitle: "Пустое описание",
		mediaUrl: url,
		favourite: newState,
		expirationDate: 10,
		originalAmount: 15,
		remainAmount: 5,
		participantsCount: 1434
	)
	return Effect(value: response)
}
