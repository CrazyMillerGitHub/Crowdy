//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import ComposableArchitecture
import TCACoordinators

public enum DetailCoordinator {}

extension DetailCoordinator {

    public struct CoordinatorState: Equatable, IndexedRouterState {

        public var routes: [Route<ScreenState>]

        public init(routes: [Route<ScreenState>]) {
            self.routes = routes
        }
    }

    public enum CoordinatorAction: IndexedRouterAction {
        case goToRoot
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
                switch action {
                case .routeAction(_, action: .detail(.closeButtonTapped)):
                    return Effect(value: .goToRoot)
                case .routeAction(_, action: .detail(.previewTapped(let url))):
                    state.routes.presentCover(.preview(.init(url: url)))
                case .routeAction(_, action: .preview(.closeButtonTapped)):
                    state.routes.goBack()
                case .routeAction(_, action: .detail(.startCancellingOrder)):
                    state.routes.presentSheet(.cancel(.init()))
                case .routeAction(_, action: .detail(.startTransactionOrder(let uuid, let title, let author, let image))):
                    state.routes.presentCover(.payment(.init(uuid: uuid, title: title, author: author, image: image)))
                case .routeAction(_, action: .payment(.cancelTapped)):
                    state.routes.goBack()
                case .routeAction(_, action: .detail(.shareTapped(let url))):
                    state.routes.presentSheet(.share(.init(fundId: .init())))
                case .routeAction(_, action: .cancel(.confirmCancellingOrder)):
                    state.routes.goBack()
                case _:
                    break
                }
                return .none
            }
        )
}
