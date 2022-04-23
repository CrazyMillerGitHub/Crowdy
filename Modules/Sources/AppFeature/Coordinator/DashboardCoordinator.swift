//
//  DashboardCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

#if !APPCLIP

import Foundation
import TCACoordinators
import ComposableArchitecture
import SwiftUI
import DashboardFeature
import DetailFeature
import PreviewFeature

struct DashboardCoordinatorView: View {

    public typealias DashboardStore = Store<DashboardCoordinatorState, DashboardCoordinatorAction>

    let store: DashboardStore

    public init(store: DashboardStore) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /ScreenState.dashboardState,
                    action: ScreenAction.dashboardAction,
                    then: DashboardView.init
                )
                CaseLet(
                    state: /ScreenState.homeDetailState,
                    action: ScreenAction.detailAction,
                    then: DetailView.init
                )
                CaseLet(
                    state: /ScreenState.previewState,
                    action: ScreenAction.previewAction,
                    then: PreviewView.init
                )
            }
        }
    }
}

// MARK: - DiscoveryCoordinator
public struct DashboardCoordinatorState: Equatable, IndexedRouterState {

    static let initialState: Self = .init(
        routes: [.root(.dashboardState(.init()))]
    )

    public var routes: [Route<ScreenState>]
}

public enum DashboardCoordinatorAction: IndexedRouterAction {

  case routeAction(Int, action: ScreenAction)
  case updateRoutes([Route<ScreenState>])
}

struct DashboardCoordinatorEnvironment {}

typealias DashboardCoordinatorReducer = Reducer<
    DashboardCoordinatorState, DashboardCoordinatorAction, DashboardCoordinatorEnvironment
>

let dashboardCoordinatorReducer: DashboardCoordinatorReducer = screenReducer
    .forEachIndexedRoute(environment: { _ in .dev(environment: .init()) })
    .withRouteReducer(
        Reducer { state, action, environment in
            switch action {
            case .routeAction(_, action: .dashboardAction(.selectFund(let id))):
                state.routes.presentCover(.homeDetailState(.init(uuid: id)))
            case .routeAction(_, action: .detailAction(.previewTapped(let url))):
                state.routes.presentCover(.previewState(.init(url: url)))
            case .routeAction(_, action: .previewAction(.closeButtonTapped)):
                state.routes.goBack()
            case .routeAction(_, action: .detailAction(.closeButtonTapped)):
                state.routes.goBack()
            case _:
                break
            }
            return .none
        }
    )

#endif
