//
//  SettingsCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

import ComposableArchitecture
import TCACoordinators

public enum SettingsCoordinator {

    public struct Environment {
        public init() {}
    }

    public struct CoordinatorState: Equatable, IndexedRouterState {
        public let id = UUID()
        static let initialState = Self(
            routes: [.root(.settings(.init()))]
        )
        public var routes: [Route<ScreenState>]
    }

    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
        case signedOut
    }

    public typealias CoordinatorReducer = Reducer<
        CoordinatorState,
        CoordinatorAction,
        Environment
    >

    static let coordinatorReducer: CoordinatorReducer = screenReducer
        .forEachIndexedRoute(environment: { _ in .init() })
        .withRouteReducer(
            Reducer<CoordinatorState, CoordinatorAction, Environment> { state, action, environment in
                switch action {
                case .routeAction(_, action: .settings(.logOutButtonTapped)):
                    return Effect(value: .signedOut)
                case .routeAction(_, action: .settings(.editButtonTapped)):
                    state.routes.presentSheet(.editProfile(.initialState))
                case .routeAction(_, action: .editProfile(.alertOkTapped)):
                    state.routes.goBack()
                case _:
                    break
                }
                return .none
            }
        )
}
