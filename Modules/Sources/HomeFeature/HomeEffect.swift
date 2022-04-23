//
//  HomeEffect.swift
//  
//
//  Created by Mikhail Borisov on 10.01.2022.
//

#if !APPCLIP

import Foundation
import ComposableArchitecture
import Core

public func loadFundsRequest(decoder: JSONDecoder, baseURL: URL) -> Effect<[FundDTO], APIError> {
    return URLSession.shared.dataTaskPublisher(for: baseURL.appendingPathComponent("get"))
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: [FundDTO].self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

public func dummyLoadFundsRequest(decoder: JSONDecoder) -> Effect<[FundDTO], APIError> {
    var fund = FundDTO.fixture
    fund.id = .init(uuidString: "D0AD236D-0100-0000-A0BB-236D01000000")!
    return Effect(value: [fund])
        .delay(for: 1, scheduler: DispatchQueue.main)
        .eraseToEffect()
}

public func updateFavoriteFundRequest(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: EditFavoruriteRequest
) -> Effect<FundDTO, APIError> {
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent("update"))
    urlRequest.httpBody = try? encoder.encode(request)
    urlRequest.httpMethod = "POST"
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: FundDTO.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

public func dummyUpdateFavoriteFundRequest(
    decoder: JSONDecoder,
    encoder: JSONEncoder,
    baseURL: URL,
    request: EditFavoruriteRequest
) -> Effect<FundDTO, APIError> {
    var fund: FundDTO = .fixture
    fund.id = request.crowdfindingId
    fund.isFavorite = request.newState
    return Effect(value: fund)
}

public struct EditFavoruriteRequest: Encodable {
    let userId: Int64
    let crowdfindingId: UUID
    let newState: Bool
}

#endif
