//
//  AddCoordinator.swift
//  
//
//  Created by Mikhail Borisov on 02.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import AuthFeature

public enum AddCoordinator {}

extension AddCoordinator {

    public struct CoordinatorState: Equatable, IndexedRouterState {

        public var routes: [Route<ScreenState>]

        public static let initialState = Self(
            routes: [.root(.fundSelection(.init()))]
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
        CoordinatorState,
        CoordinatorAction,
        Environment
    > = screenReducer
        .forEachIndexedRoute(environment: { _ in .init() })
        .withRouteReducer(
            Reducer<CoordinatorState, CoordinatorAction, Environment> { state, action, environment in
                switch action {
                case .routeAction(_, action: .fundSelection(.internalFundTapped)):
                    state.routes.presentCover(.add(.init(isHiddenFund: true)))
                case .routeAction(_, action: .fundSelection(.externalFundTapped)):
                    state.routes.presentCover(.add(.init()))
                case .routeAction(_, action: .add(.cancelTapped)):
                    state.routes.goBack()
                case .routeAction(_, action: .add(.saveSuccess(let fundId))):
                    return Effect.routeWithDelaysIfUnsupported(state.routes) {
                        $0.goBack()
                        $0.presentCover(.share(.init(fundId: fundId)))
                    }
                case _:
                    break
                }
                return .none
            }
        )
}
