//
//  AppCoordinator.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI

public enum AppCoordinator {}

extension AppCoordinator {

    public struct CoordinatorState: Equatable, IndexedRouterState {

        public var routes: [Route<ScreenState>]

        public static let initialState = Self(
            routes: [.root(.splash(.init()))]
        )
    }
    
    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
    }

    public struct Environment {
        public init() {}
    }
    
    public static let coordinatorReducer: Reducer<
        AppCoordinator.CoordinatorState,
        AppCoordinator.CoordinatorAction,
        AppCoordinator.Environment
    > = screenReducer
        .forEachIndexedRoute(environment: { _ in .init() })
        .withRouteReducer(
            Reducer<CoordinatorState, CoordinatorAction, Environment> { state, action, environment in
                func replaceRootWithOnboarding() {
                    state.routes = [
                        .root(.onboarding(.initialState))
                    ]
                }
                switch action {
                case .routeAction(_, action: .splash(.notSignedIn)):
                    replaceRootWithOnboarding()
                case .routeAction(_, action: .splash(.signedIn)):
                    state.routes = [
                        .root(.main(.initialState))
                    ]
                case .routeAction(_, action: .main(.signedOut)):
                    replaceRootWithOnboarding()
                case .routeAction(_, action: .onboarding(.signedIn)):
                    state.routes = [
                        .root(.main(.initialState))
                    ]
                case _:
                    break
                }
                return .none
            }
        )
}
