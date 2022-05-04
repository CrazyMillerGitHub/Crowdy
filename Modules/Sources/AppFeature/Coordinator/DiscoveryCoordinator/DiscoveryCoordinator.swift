//
//  DiscoveryCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

import ComposableArchitecture
import TCACoordinators
import SwiftUI
import OnboardingFeature
import AuthFeature
import ForgetFeature

public enum DiscoveryCoordinator {

    public struct Environment {}

    public struct CoordinatorState: Equatable, IndexedRouterState {
        public let id = UUID()
        static let initialState = Self(
            routes: [.root(.home(.init(funds: [])))]
        )

        public var routes: [Route<ScreenState>]
    }

    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
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
                case .routeAction(_, action: .home(.addTapped)):
                    state.routes.presentSheet(.add(.initialState))
                case .routeAction(_, action: .home(.selectFund(let uuid))):
                    state.routes.presentCover(
                        .detail(
                            .init(routes: [.root(.detail(.init(uuid: uuid)))])
                        )
                    )
                case .routeAction(_, action: .detail(.goToRoot)):
                    state.routes.goBack()
                case .routeAction(_, action: .home(.showNews)):
                    state.routes.presentSheet(.news(.init()))
                case .routeAction(_, action: .news(.continueButtonTapped)):
                    state.routes.goBack()
                case _:
                    break
                }
                return .none
            }
        )
}
