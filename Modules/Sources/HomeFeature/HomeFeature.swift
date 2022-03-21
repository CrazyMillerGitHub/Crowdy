//
//  HomeFeature.swift
//  
//
//  Created by Mikhail Borisov on 09.01.2022.
//

import Foundation
import ComposableArchitecture
import Core
import SwiftUI

public struct HomeEnvironment {

    var loadFundsRequest: (JSONDecoder) -> Effect<[Fund], APIError>

    public init(loadFundsRequest: @escaping (JSONDecoder) -> Effect<[Fund], APIError>) {
        self.loadFundsRequest = loadFundsRequest
    }
}

public enum HomeAction: BindableAction {
    case selectFund(UUID)
    case toggleFavorite(UUID)
    case onAppear
    case addTapped
    case loadFunds(Result<[Fund], APIError>)
    case loadFundsFailed
    case binding(BindingAction<HomeState>)
}

public let homeReducer = Reducer<
    HomeState,
    HomeAction,
    SystemEnvironment<HomeEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        state = .fixture
        return environment
            .loadFundsRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(HomeAction.loadFunds)
    case .loadFunds(let result):
        guard case .success(let funds) = result else {
            return .none
        }
        state.isLoaded = true
        state.funds = funds
        return .none
    case _:
        return .none
    }
}
.binding()
