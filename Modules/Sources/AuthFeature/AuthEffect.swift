//
//  AuthEffect.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

import ComposableArchitecture
import Core

func authEffect(
	decoder: JSONDecoder,
	login: String,
	password: String
) -> Effect<AuthModel, APIError> {
	guard let url = URL(string: "test.app.com/auth") else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: AuthModel.self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func saveModelRequest(storage: StorageProtocol, model: AuthModel) {}

func dummyAuthEffect(
	decoder: JSONDecoder,
	login: String,
	password: String
) -> Effect<AuthModel, APIError> {
	return Effect(value: AuthModel(login: "1234", passwordHash: UUID().description, user: .init()))
}
