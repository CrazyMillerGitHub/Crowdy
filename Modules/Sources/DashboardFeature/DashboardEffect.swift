//
//  DashboardEffect.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import ComposableArchitecture
import Core

public struct UserFundsRequest: Encodable {

    let userId: Int64
}

public func getUserFundsRequest(decoder: JSONDecoder, encoder: JSONEncoder, baseURL: URL, request: UserFundsRequest) -> Effect<[FundDTO], APIError> {
    var urlRequest = URLRequest(url: baseURL)
    urlRequest.httpBody = try? encoder.encode(request)
    urlRequest.httpMethod = "POST"
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
        .mapError { _ in APIError.downloadError }
        .map(\.data)
        .decode(type: [FundDTO].self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

public func dummyGetUserFundsRequest(decoder: JSONDecoder, encoder: JSONEncoder, baseURL: URL, request: UserFundsRequest) -> Effect<[FundDTO], APIError> {
    return Effect(value: [.fixture])
        .delay(for: 1, scheduler: DispatchQueue.main)
        .eraseToEffect()
}

#endif
