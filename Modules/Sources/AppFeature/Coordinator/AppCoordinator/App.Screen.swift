//
//  App.Screen.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import ComposableArchitecture

extension AppCoordinator {

    public enum ScreenState: Equatable {
        case splash(Splash.State)
        case onboarding(OnboardingCoordinator.CoordinatorState)
        case main(MainCoordinator.CoordinatorState)
    }

    public enum ScreenAction {
        case splash(Splash.Action)
        case onboarding(OnboardingCoordinator.CoordinatorAction)
        case main(MainCoordinator.CoordinatorAction)
    }

    typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >
    static let screenReducer: ScreenReducer = .combine(
        Splash.reducer.pullback(
            state: /ScreenState.splash,
            action: /ScreenAction.splash,
            environment: { _ in
                return .dev(environment: .init())
            }
        ),
        OnboardingCoordinator.coordinatorReducer.pullback(
            state: /ScreenState.onboarding,
            action: /ScreenAction.onboarding,
            environment: { _ in
                return .init()
            }
        ),
        MainCoordinator.coordinatorReducer.pullback(
            state: /ScreenState.main,
            action: /ScreenAction.main,
            environment: { _ in
                return .init()
            }
        )
    )
}
