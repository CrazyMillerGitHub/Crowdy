//
//  SettingsCoordinatorView.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

#if !APPCLIP

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import SettingsFeature
import AuthFeature
import OnboardingFeature
import ForgetFeature
import EditProfileFeature

public struct SettingsCoordinatorView: View {

    public typealias SettingsStore = Store<SettingsCoordinatorState, SettingsCoordinatorAction>

    let store: SettingsStore

    public init(store: SettingsStore) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /ScreenState.settingsState,
                    action: ScreenAction.settinsgAction,
                    then: SettingsView.init
                )
                CaseLet(
                    state: /ScreenState.authState,
                    action: ScreenAction.authAction,
                    then: AuthView.init
                )
                CaseLet(
                    state: /ScreenState.onboardingState,
                    action: ScreenAction.onboardingAction,
                    then: OnboardingView.init
                )
                CaseLet(
                    state: /ScreenState.forgetState,
                    action: ScreenAction.forgetAction,
                    then: ForgetView.init
                )
                CaseLet(
                    state: /ScreenState.editProfileState,
                    action: ScreenAction.editProfileAction,
                    then: EditProfileView.init
                )
            }
        }
    }
}

// MARK: - SettingsCoordinator
public struct SettingsCoordinatorState: Equatable, IndexedRouterState {

    static let initialState: Self = .init(
        routes: [.root(.settingsState(.init()))]
    )

    public var routes: [Route<ScreenState>]
}

public enum SettingsCoordinatorAction: IndexedRouterAction {

  case routeAction(Int, action: ScreenAction)
  case updateRoutes([Route<ScreenState>])
}

struct SettingsCoordinatorEnvironment {}

typealias SettingsCoordinatorReducer = Reducer<
    SettingsCoordinatorState, SettingsCoordinatorAction, SettingsCoordinatorEnvironment
>

let settingsCoordinatorReducer: SettingsCoordinatorReducer = screenReducer
    .forEachIndexedRoute(environment: { _ in .dev(environment: .init()) })
    .withRouteReducer(
        Reducer { state, action, environment
            in
            switch action {
            case .routeAction(_, action: .settinsgAction(.logOutButtonTapped)):
                state.routes.presentCover(.onboardingState(.initialState), embedInNavigationView: true)
            case .routeAction(_, action: .onboardingAction(.loginTapped)):
                state.routes.push(.authState(.initialState))
            case .routeAction(_, action: .onboardingAction(.registerTapped)):
                state.routes.push(.authState(.initialState))
            case .routeAction(_, action: .authAction(.areYouRegisteredTapped)):
                return Effect.routeWithDelaysIfUnsupported(state.routes) {
                    $0.goBack()
                    $0.push(.authState(.initialState))
                }
            case .routeAction(_, action: .authAction(.forgotButtonTapped)):
                state.routes.push(.forgetState(.initialState))
            case .routeAction(_, action: .settinsgAction(.editButtonTapped)):
                state.routes.presentSheet(.editProfileState(.initialState))
            case _:
                break
            }
            return .none
        }
    )

#endif
