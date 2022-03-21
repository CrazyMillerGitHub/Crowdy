//
//  SettingsCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import SettingsFeature
import AuthFeature

public struct SettingsCoordinatorView: View {

    public typealias SettingsStore = Store<SettingsCoordinatorState, SettingsCoordinatorAction>

    let store: SettingsStore

    public init(store: SettingsStore) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /ScreenState.settingsState,
                    action: ScreenAction.settinsgAction,
                    then: SettingsView.init
                )
                CaseLet(
                    state: /ScreenState.authState,
                    action: ScreenAction.authAction,
                    then: AuthView.init
                )
            }
        }
    }
}

// MARK: - SettingsCoordinator
public struct SettingsCoordinatorState: Equatable, IndexedRouterState {

    static let initialState: Self = .init(
        routes: [.root(.settingsState(.init()))]
    )

    public var routes: [Route<ScreenState>]
}

public enum SettingsCoordinatorAction: IndexedRouterAction {

  case routeAction(Int, action: ScreenAction)
  case updateRoutes([Route<ScreenState>])
}

struct SettingsCoordinatorEnvironment {}

typealias SettingsCoordinatorReducer = Reducer<
    SettingsCoordinatorState, SettingsCoordinatorAction, SettingsCoordinatorEnvironment
>

let settingsCoordinatorReducer: SettingsCoordinatorReducer = screenReducer
    .forEachIndexedRoute(environment: { _ in .dev(environment: .init()) })
    .withRouteReducer(
        Reducer { state, action, environment in
            switch action {
            case .routeAction(_, action: .settinsgAction(.logOutButtonTapped)):
                state.routes.presentCover(.authState(.init()))
            case _:
                break
            }
            return .none
        }
    )
