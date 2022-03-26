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
    var updateFavoriteFundRequest: (JSONDecoder, JSONEncoder, URL, EditFavoruriteRequest) -> Effect<Fund, APIError>

    public init(
        loadFundsRequest: @escaping (JSONDecoder) -> Effect<[Fund], APIError>,
        updateFavoriteFundRequest: @escaping (JSONDecoder, JSONEncoder, URL, EditFavoruriteRequest) -> Effect<Fund, APIError>
    ) {
        self.loadFundsRequest = loadFundsRequest
        self.updateFavoriteFundRequest = updateFavoriteFundRequest
    }
}

public enum HomeAction: BindableAction {
    // Routing
    case onAppear
    case addTapped
    case goToAuth
    case selectFund(UUID)

    // Load funds
    case loadFunds(Result<[Fund], APIError>)
    case loadFundsFailed

    // Toggle Favorite
    case toggleFavorite(UUID)
    case toggleFavoriteLoaded(Result<Fund, APIError>)
    case toggleFavoriteFailed
    case toggleFavouriteSucceed

    // Binding
    case binding(BindingAction<HomeState>)
}

public let homeReducer = Reducer<
    HomeState,
    HomeAction,
    SystemEnvironment<HomeEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        guard state.isLoading else { return .none }
        state = .fixture
        let remoteConfig = environment.remoteConfig()
        guard remoteConfig.isUserAuthentificated else {
            return Effect(value: .goToAuth)
        }
        return environment
            .loadFundsRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(HomeAction.loadFunds)
    case .loadFunds(let result):
        guard case .success(let funds) = result else {
            return .none
        }
        state.isLoading = false
        state.funds = funds
        return .none
    case .toggleFavorite(let uuid):
        guard let selectedFund = state.funds.first(where: { fund in return fund.id == uuid }) else {
            return Effect(value: .toggleFavoriteFailed)
        }
        return environment
            .updateFavoriteFundRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL.appendingPathComponent("funds"),
                .init(userId: environment.currentUser().uuid, crowdfindingId: uuid, newState: !selectedFund.isFavorite)
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(HomeAction.toggleFavoriteLoaded)
    case .toggleFavoriteLoaded(let response):
        guard case .success(let newFund) = response else {
            return Effect(value: .toggleFavoriteFailed)
        }
        if let elementId = state.funds.firstIndex(where: { fund in fund.id == newFund.id }) {
            state.funds[elementId] = newFund
        }
        return .init(value: .toggleFavouriteSucceed)
    case _:
        return .none
    }
}
.binding()
