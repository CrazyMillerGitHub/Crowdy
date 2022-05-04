//
//  MainCoordinator.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI

public enum MainCoordinator {

    public struct Environment {}

    public struct CoordinatorState: Equatable, IndexedRouterState {

        static var initialState = Self(
            settings: .initialState,
            discovery: .initialState,
            dashboard: .initialState,
            routes: []
        )

        var settings: SettingsCoordinator.CoordinatorState
        var discovery: DiscoveryCoordinator.CoordinatorState
        var dashboard: DashboardCoordinator.CoordinatorState

        public var routes: [Route<ScreenState>]

    }

    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
        case signedOut
        case discovery(DiscoveryCoordinator.CoordinatorAction)
        case settings(SettingsCoordinator.CoordinatorAction)
        case dashboard(DashboardCoordinator.CoordinatorAction)
    }

    public typealias CoordinatorReducer = Reducer<
        CoordinatorState,
        CoordinatorAction,
        Environment
    >

    static let coordinatorReducer: CoordinatorReducer = .combine(
        SettingsCoordinator.coordinatorReducer.pullback(
            state: \CoordinatorState.settings,
            action: /CoordinatorAction.settings,
            environment: { _ in
                return .init()
            }
        ),
        DiscoveryCoordinator.coordinatorReducer.pullback(
            state: \CoordinatorState.discovery,
            action: /CoordinatorAction.discovery,
            environment: { _ in
                return .init()
            }
        ),
        DashboardCoordinator.coordinatorReducer.pullback(
            state: \CoordinatorState.dashboard,
            action: /CoordinatorAction.dashboard,
            environment: { _ in
                return .init()
            }
        ),
        Reducer { state, action, environment in
            switch action {
            case .settings(.signedOut):
                return Effect(value: .signedOut)
            case _:
                break
            }
            return .none
        }
    )
}
