//
//  SettingsFeature.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

#if !APPCLIP

import Core
import OperationRow
import ComposableArchitecture
import SwiftUI

public struct SettingsState: Equatable {

    public var operations: [OperationModel] = [.fixture]
    @BindableState public var spent: Price = .fixture
    public var isCardAvailable = true
    public var isOperationsAvailble = true
    public var isLoading: Bool = true
    public var isOperationsLoading: Bool = true

    public init() {}
}

public enum SettingsAction: BindableAction {
    case onAppear

    // Requests
    case didLoadUser(Result<User, StorageError>)
    case didLoadUserFailed
    case didLoadOpeartions(Result<[OperationModel], APIError>)
    case didLoadOperationsFailed

    // Routing
    case logOutButtonTapped
    case editButtonTapped

    // Binding
    case binding(BindingAction<SettingsState>)
}

public struct SettingsEnvironment {

    var loadUserRequest: (PersistenceController) -> Effect<User, StorageError>
    var loadOperationsRequest: (JSONDecoder, JSONEncoder, URL) -> Effect<[OperationModel], APIError>

    public init(
        loadUserRequest: @escaping (PersistenceController) -> Effect<User, StorageError>,
        loadOperationsRequest: @escaping (JSONDecoder, JSONEncoder, URL) -> Effect<[OperationModel], APIError>
    ) {
        self.loadUserRequest = loadUserRequest
        self.loadOperationsRequest = loadOperationsRequest
    }
}

public let settingsReducer = Reducer<
    SettingsState,
    SettingsAction,
    SystemEnvironment<SettingsEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment
            .loadUserRequest(environment.storage())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(SettingsAction.didLoadUser)
    case .didLoadUser(let response):
        state.isCardAvailable = environment.featureAvailability().isCardAvailable
        state.isOperationsAvailble = environment.featureAvailability().isOperationsAvailble
        state.isLoading = false
        guard case let .success(model) = response else {
            return Effect(value: .didLoadUserFailed)
        }
        guard state.isOperationsAvailble else { return .none }
        return environment
            .loadOperationsRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL.appendingPathComponent("operations")
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(SettingsAction.didLoadOpeartions)
    case .didLoadOpeartions(let response):
        state.isOperationsLoading = false
        guard case let .success(operations) = response else {
            return Effect(value: .didLoadOperationsFailed)
        }
        state.operations = operations
        fallthrough
    case .logOutButtonTapped:
        return .none
    case .editButtonTapped:
        return .none
    case _:
        return .none
    }
}.binding()

#endif
