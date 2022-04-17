//
//  DiscoveryCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import HomeFeature
import PreviewFeature
import DetailFeature
import AddFeature
import AuthFeature
import PaymentFeature
import ShareQrFeature

public struct DiscoveryCoordinatorView: View {

    public typealias DiscoveryStore = Store<DiscoveryCoordinatorState, DiscoveryCoordinatorAction>

    let store: DiscoveryStore

    public init(store: DiscoveryStore) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /ScreenState.homeState,
                    action: ScreenAction.homeAction,
                    then: HomeView.init
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
                CaseLet(
                    state: /ScreenState.previewState,
                    action: ScreenAction.previewAction,
                    then: PreviewView.init
                )
                CaseLet(
                    state: /ScreenState.addState,
                    action: ScreenAction.addAction,
                    then: AddView.init
                )
                CaseLet(
                    state: /ScreenState.authState,
                    action: ScreenAction.authAction,
                    then: AuthView.init
                )
                CaseLet(
                    state: /ScreenState.paymentState,
                    action: ScreenAction.paymentAction,
                    then: PaymentView.init
                )
                CaseLet(
                    state: /ScreenState.shareState,
                    action: ScreenAction.shareAction,
                    then: ShareView.init
                )
            }
        }
    }
}

// MARK: - DiscoveryCoordinator
public struct DiscoveryCoordinatorState: Equatable, IndexedRouterState {

    static let initialState: Self = .init(
        routes: [.root(.homeState(.init(funds: .init())), embedInNavigationView: true)]
    )

    public var routes: [Route<ScreenState>]
}

public enum DiscoveryCoordinatorAction: IndexedRouterAction {
  case routeAction(Int, action: ScreenAction)
  case updateRoutes([Route<ScreenState>])
}

struct DiscoveryCoordinatorEnvironment {}

typealias DiscoveryCoordinatorReducer = Reducer<
    DiscoveryCoordinatorState, DiscoveryCoordinatorAction, DiscoveryCoordinatorEnvironment
>

let discoveryCoordinatorReducer: DiscoveryCoordinatorReducer = screenReducer
    .forEachIndexedRoute(environment: { _ in .dev(environment: .init()) })
    .withRouteReducer(
        Reducer { state, action, environment in
            switch action {
            case .routeAction(_, action: .homeAction(.selectFund(let id))):
                state.routes.presentCover(.homeDetailState(.init(uuid: id)))
            case .routeAction(_, action: .detailAction(.closeButtonTapped)):
                state.routes.goBack()
            case .routeAction(_, action: .detailAction(.previewTapped(let url))):
                state.routes.presentCover(.previewState(.init(url: url)))
            case .routeAction(_, action: .previewAction(.closeButtonTapped)):
                state.routes.goBack()
            case .routeAction(_, action: .homeAction(.addTapped)):
                state.routes.presentCover(.addState(.init()))
            case .routeAction(_, action: .addAction(.cancelTapped)):
                state.routes.goBack()
            case .routeAction(_, action: .detailAction(.startCancellingOrder)):
                state.routes.goBack()
            case .routeAction(_, action: .detailAction(.startTransactionOrder(let uuid, let title, let author, let image))):
                state.routes.presentCover(.paymentState(.init(uuid: uuid, title: title, author: author, image: image)))
            case .routeAction(_, action: .paymentAction(.cancelTapped)):
                state.routes.goBack()
            case .routeAction(_, action: .detailAction(.shareTapped(let url))):
                state.routes.presentSheet(.shareState(.init(url: url)))
//            case .routeAction(_, action: .homeAction(.goToAuth)):
//                state.routes = [.root(.authState(.init()))]
//            case .routeAction(_, action: .addAction(.receiveResponse(_))):
//                state.routes.goBackToRoot()
            case _:
                break
            }
            return .none
        }
    )
