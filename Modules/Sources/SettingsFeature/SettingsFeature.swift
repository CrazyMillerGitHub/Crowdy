//
//  SettingsFeature.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import Core
import ComposableArchitecture

public struct SettingsState: Equatable {

    public init() {}
}

public enum SettingsAction {
    case onAppear
    case didLoadUser(User)
    case logOutButtonTapped
    case editButtonTapped
}

public struct SettingsEnvironment {

    private var loadUserRequest: (StorageProtocol) -> User?

    public init(loadUserRequest: @escaping (StorageProtocol) -> User?) {
        self.loadUserRequest = loadUserRequest
    }
}

public let settingsReducer = Reducer<
    SettingsState,
    SettingsAction,
    SystemEnvironment<SettingsEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return .none
    case .didLoadUser(let model):
        return .none
    case .logOutButtonTapped:
        return .none
    case .editButtonTapped:
        return .none
    }
}
