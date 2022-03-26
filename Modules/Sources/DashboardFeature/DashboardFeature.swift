//
//  DashboardFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import Foundation
import Core
import ComposableArchitecture

public struct DashboardState: Equatable {

    var isLoading: Bool = true
    var activateFunds: [Fund] = [.fixture]
    var previousFunds: [Fund] = [.fixture]

    public init() {}
}

public enum DashboardAction {
    case onAppear
    case fundsLoaded(Result<[Fund], APIError>)
    case fundsFailed
    case selectFund(UUID)
}

public struct DashboardEnvironment {

    var getUserFundsRequest: (JSONDecoder, JSONEncoder, URL, UserFundsRequest) -> Effect<[Fund], APIError>

    public init(getUserFundsRequest: @escaping (JSONDecoder, JSONEncoder, URL, UserFundsRequest) -> Effect<[Fund], APIError>) {
        self.getUserFundsRequest = getUserFundsRequest
    }
    
}

public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    SystemEnvironment<DashboardEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment
            .getUserFundsRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL,
                .init(userId: environment.currentUser().uuid)
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(DashboardAction.fundsLoaded)
    case .fundsLoaded(let response):
        guard case .success(let funds) = response else {
            return Effect(value: .fundsFailed)
        }
        state.isLoading = false
        state.activateFunds = funds
        state.previousFunds = []
        fallthrough
    case _:
        return .none
    }
}
