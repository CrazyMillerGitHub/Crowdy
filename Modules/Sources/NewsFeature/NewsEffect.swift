//
//  NewsEffect.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import Core
import Combine
import ComposableArchitecture

func newsEffect(decoder: JSONDecoder) -> Effect<[NewsModel], APIError> {
	guard let url = URL(string: "api.test/newsEffect") else {
		assertionFailure("URL не может быть невалидным")
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: [NewsModel].self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func dummyNewsEffect(decoder: JSONDecoder) -> Effect<[NewsModel], APIError> {
	let url = URL(fileURLWithPath: "")
	let response: [NewsModel] = [
		.init(identifier: UUID(), title: "Feature 1", subtitle: "Some news", url: url),
		.init(identifier: UUID(), title: "Feature 2", subtitle: "Some news", url: url),
		.init(identifier: UUID(), title: "Feature 3", subtitle: "Some news", url: url),
		.init(identifier: UUID(), title: "Feature 4", subtitle: "Some news", url: url),
	]
	return Effect(value: response)
}
