//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 22.03.2022.
//

#if !APPCLIP

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import AuthFeature

//struct RootState: Equatable, IndexedRouterState {
//
//    public static let initialState: Self = .init(
//        tabBarState: .initialState,
//        authState: .initialState,
//        routes: [.root(.authState(.initialState))]
//    )
//
//    var tabBarState: MainTabCoordinatorState
//    var authState: AuthState
//
//    var routes:  [Route<ScreenState>]
//}
//
//enum RootAction: IndexedRouterAction {
//    case tabBarAction(MainTabCoordinatorAction)
//    case authAction(AuthAction)
//
//    case routeAction(Int, action: ScreenAction)
//    case updateRoutes([Route<ScreenState>])
//}
//
//struct CustomRootView: View {
//
//    typealias RootStore = Store<RootState, RootAction>
//
//    private let store: RootStore
//
//    init(store: RootStore) {
//        self.store = store
//    }
//
//    var body: some View {
//        TCARouter(store) { screen in
//            SwitchStore(screen) {
//                CaseLet(
//                    state: /RootState.tabBarState,
//                    action: RootAction.tabBarAction,
//                    then: RootView.init
//                )
//                CaseLet(
//                    state: /ScreenState.authState,
//                    action: RootAction.authAction,
//                    then: AuthView.init
//                )
//            }
//        }
//    }
//}

#endif
