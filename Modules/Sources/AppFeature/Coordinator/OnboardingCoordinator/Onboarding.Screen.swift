//
//  Onboarding.Screen.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import ComposableArchitecture
import ForgetFeature
import AuthFeature
import OnboardingFeature
import Core

extension OnboardingCoordinator {

    public typealias ScreenReducer = Reducer<
        OnboardingCoordinator.ScreenState,
        OnboardingCoordinator.ScreenAction,
        OnboardingCoordinator.Environment
    >

    public enum ScreenState: Equatable, Identifiable {
        case onboarding(OnboardingState)
        case auth(AuthState)
        case forget(ForgetState)

        public var id: UUID {
            switch self {
            case .onboarding(let state):
                return state.id
            case .auth(let state):
                return state.id
            case .forget(let state):
                return state.id
            }
        }
    }

    public enum ScreenAction {
        case onboarding(OnboardingAction)
        case auth(AuthAction)
        case forget(ForgetAction)
    }

    static let screenReducer: ScreenReducer = .combine(
        onboardingReducer.pullback(
            state: /ScreenState.onboarding,
            action: /ScreenAction.onboarding,
            environment: { _ in
                return .dev(
                    environment: OnboardingEnvironment()
                )
            }
        ),
        authReducer.pullback(
            state: /ScreenState.auth,
            action: /ScreenAction.auth,
            environment: { _ in
                return .dev(
                    environment:
                        AuthEnvironment(
                            loginUserRequest: dummyLoginRequest,
                            registerUserRequest: dummyRegisterRequest,
                            saveModelRequest: dummySaveModelRequest
                        )
                )
            }
        ),
        forgetReducer.pullback(
            state: /ScreenState.forget,
            action: /ScreenAction.forget,
            environment: { _ in
                return .dev(
                    environment: ForgetEnvironment(
                        resetPasswordRequest: dummyResetPasswordRequest
                    )
                )
            }
        )
    )
}
