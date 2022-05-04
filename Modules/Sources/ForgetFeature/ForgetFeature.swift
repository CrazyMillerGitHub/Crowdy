//
//  ForgetFeature.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

import ComposableArchitecture
import Core

public struct ForgetState: Equatable {

    @BindableState
    public var email: String

    var requestIsReady: Bool {
        return !email.isEmpty && Predicate.email.evaluate(email)
    }

    var alert: AlertState<ForgetAction>?
    public let id = UUID()

    public static var initialState = Self(email: "")

    public init(email: String) {
        self.email = email
    }

    public static func == (lhs: ForgetState, rhs: ForgetState) -> Bool {
        return lhs.email == rhs.email
        && lhs.alert?.id == rhs.alert?.id
        && lhs.requestIsReady == rhs.requestIsReady
    }
}

public enum ForgetAction: BindableAction {
    case sendRequestTapped
    case alertOkTapped
    case binding(BindingAction<ForgetState>)
}

public struct ForgetEnvironment {

    var resetPasswordRequest: (JSONDecoder, ResetPasswordRequest) -> Effect<EmptyResponse, APIError>

    public init(resetPasswordRequest: @escaping (JSONDecoder, ResetPasswordRequest) -> Effect<EmptyResponse, APIError>) {
        self.resetPasswordRequest = resetPasswordRequest
    }
}
