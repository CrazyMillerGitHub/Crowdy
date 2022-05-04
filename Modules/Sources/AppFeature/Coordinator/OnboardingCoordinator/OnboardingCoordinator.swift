//
//  OnboardingCoordinator.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import ComposableArchitecture
import TCACoordinators
import SwiftUI
import OnboardingFeature
import AuthFeature
import ForgetFeature

public enum OnboardingCoordinator {

    public struct Environment {}

    public struct CoordinatorState: Equatable, IndexedRouterState {
        static let initialState = Self(
            routes: [.root(.onboarding(.initialState))]
        )

        public var routes: [Route<ScreenState>]
    }

    public enum CoordinatorAction: IndexedRouterAction {
        case routeAction(Int, action: ScreenAction)
        case updateRoutes([Route<ScreenState>])
        case signedIn
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
                case .routeAction(_, action: .onboarding(.loginTapped)):
                    state.routes.push(.auth(.initialState))
                case .routeAction(_, action: .onboarding(.registerTapped)):
                    state.routes.push(.auth(.initialState))
                case .routeAction(_, action: .auth(.areYouRegisteredTapped)):
                    return Effect.routeWithDelaysIfUnsupported(state.routes) {
                        $0.goBack()
                        $0.push(.auth(.initialState))
                    }
                case .routeAction(_, action: .auth(.forgotButtonTapped)):
                    state.routes.push(.forget(.initialState))
                case .routeAction(_, action: .auth(.authCompleted)):
                    return Effect(value: .signedIn)
                case _:
                    break
                }
                return .none
            }
        )
}
