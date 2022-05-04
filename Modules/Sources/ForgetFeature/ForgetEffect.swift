//
//  ForgetEffect.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

public struct EmptyResponse: Decodable {}
public struct ResetPasswordRequest: Encodable {}

import Foundation
import ComposableArchitecture
import Core

public func resetPasswordRequest(decoder: JSONDecoder, request: ResetPasswordRequest) -> Effect<EmptyResponse, APIError> {
    return Effect(value: EmptyResponse())
}

public func dummyResetPasswordRequest(decoder: JSONDecoder, request: ResetPasswordRequest) -> Effect<EmptyResponse, APIError> {
    return Effect(value: EmptyResponse())
}

