//
//  DashboardCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

import TCACoordinators
import ComposableArchitecture
import Foundation

public enum DashboardCoordinator {}

extension DashboardCoordinator {

    public struct CoordinatorState: Equatable, IndexedRouterState {

        let id = UUID()
        public var routes: [Route<ScreenState>]

        static let initialState: Self = .init(
            routes: [.root(.dashboard(.init()))]
        )
    }

    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
    }

    public static let coordinatorReducer: Reducer<
        CoordinatorState,
        CoordinatorAction,
        Environment
    > = screenReducer
        .forEachIndexedRoute(environment: { _ in .init() })
        .withRouteReducer(
            Reducer<CoordinatorState, CoordinatorAction, Environment> { state, action, environment in
                return .none
            }
        )
}
