//
//  AuthEffect.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

#if !APPCLIP

import ComposableArchitecture
import Core

public func loginEffect(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: LoginRequest
) -> Effect<AuthModel, APIError> {
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent("login"))
    urlRequest.httpBody = try? encoder.encode(request)
    urlRequest.httpMethod = "POST"
	return URLSession.shared.dataTaskPublisher(for: urlRequest)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: AuthModel.self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

public func registerEffect(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: RegisterRequest
) -> Effect<AuthModel, APIError> {
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent("register"))
    urlRequest.httpBody = try? encoder.encode(request)
    urlRequest.httpMethod = "POST"
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: AuthModel.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

public func dummySaveModelRequest(storage: StorageProtocol, model: AuthModel) {}

public func dummyLoginRequest(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: LoginRequest
) -> Effect<AuthModel, APIError> {
    return Effect(value: AuthModel(login: "1234", passwordHash: UUID().description, user: .fixture))
}

public func dummyRegisterRequest(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: RegisterRequest
) -> Effect<AuthModel, APIError> {
    return Effect(value: AuthModel(login: "1234", passwordHash: UUID().description, user: .fixture))
}

#endif
