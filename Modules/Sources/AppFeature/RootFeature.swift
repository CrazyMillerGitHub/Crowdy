//
//  RootFeature.swift
//  
//
//  Created by Mikhail Borisov on 07.01.2022.
//

import Core
import ComposableArchitecture
import HomeFeature
import NewsFeature
import SettingsFeature
import DashboardFeature
import DetailFeature
import AuthFeature
import PreviewFeature
import PaymentFeature
import OnboardingFeature
import AddFeature


public enum ScreenState: Equatable, Identifiable {
    /// Экран Исследование
    case homeState(HomeState)
    case homeDetailState(DetailState)
    /// Экран Настройки
    case settingsState(SettingsState)
    /// Экран Статистки
    case dashboardState(DashboardState)
    /// Экран Авторизация
    case authState(AuthState)
    /// Экран "Что нового"
    case newsState(NewsState)
    /// Экран просмотра
    case previewState(PreviewState)
    /// Экран добавления нового сбора
    case addState(AddState)
    /// Состояние платежа
    case paymentState(PaymentState)
    /// Онбординг
    case onboardingState(OnboardingState)
    

    public var id: UUID {
        return UUID()
    }
}

public enum ScreenAction {
    //// Действия на экране "Исследование"
	case homeAction(HomeAction)
    //// Действия на экране "Настройки"
    case settinsgAction(SettingsAction)
    //// Действия на экране "Статистика"
    case dashboardAction(DashboardAction)
    //// Действия на экране "Авторизация"
    case authAction(AuthAction)
    //// Действия на экране "Что нового"
	case newsAction(NewsAction)
    case detailAction(DetailAction)
    case previewAction(PreviewAction)
    case addAction(AddAction)
    case paymentAction(PaymentAction)
    case onboardingAction(OnboardingAction)
}

public struct ScreenEnvironment {

	public init() {}
}

public let screenReducer = Reducer<ScreenState, ScreenAction, SystemEnvironment<ScreenEnvironment>>.combine(
    homeReducer.pullback(
        state: /ScreenState.homeState,
        action: /ScreenAction.homeAction,
        environment: { environment in
            return .dev(
                environment: HomeEnvironment(
                    loadFundsRequest: dummyLoadFundsRequest,
                    updateFavoriteFundRequest: dummyUpdateFavoriteFundRequest
                )
            )
        }
    ),
    paymentReducer.pullback(
        state: /ScreenState.paymentState,
        action: /ScreenAction.paymentAction,
        environment: { _ in
            return .dev(
                environment: PaymentEnvironment(
                    createPaymentRequest: dummyCreatePaymentRequest
                )
            )
        }
    ),
    onboardingReducer.pullback(
        state: /ScreenState.onboardingState,
        action: /ScreenAction.onboardingAction,
        environment: { _ in
            return OnboardingEnvironment()
        }
    ),
    previewReducer.pullback(
        state: /ScreenState.previewState,
        action: /ScreenAction.previewAction,
        environment: { _ in
            return .dev(
                environment: PreviewEnvironment()
            )
        }
    ),
    addReducer.pullback(
        state: /ScreenState.addState,
        action: /ScreenAction.addAction,
        environment: { _ in
            return .dev(
                environment: AddEnvironment(
                    createFundRequest: createFundRequest,
                    saveFundRequest: saveFundRequest
                )
            )
        }
    ),
    detailReducer.pullback(
        state: /ScreenState.homeDetailState,
        action: /ScreenAction.detailAction,
        environment: { _ in
            return .dev(
                environment: DetailEnvironment(loadDetailRequest: dummyLoadDetailRequest)
            )
        }
    ),
    settingsReducer.pullback(
        state: /ScreenState.settingsState,
        action: /ScreenAction.settinsgAction,
        environment: { environment in
            return .dev(
                environment: SettingsEnvironment(
                    loadUserRequest: dummyLoadUserRequest,
                    loadOperationsRequest: dummyLoadUserOperationsRequest
                )
            )
        }
    ),
    dashboardReducer.pullback(
        state: /ScreenState.dashboardState,
        action: /ScreenAction.dashboardAction,
        environment: { environment in
            return .dev(
                environment: DashboardEnvironment(
                    getUserFundsRequest: dummyGetUserFundsRequest
                )
            )
        }
    ),
    authReducer.pullback(
        state: /ScreenState.authState,
        action: /ScreenAction.authAction,
        environment: { environment in
            return .dev(
                environment:
                    AuthEnvironment(
                        loginUserRequest: loginEffect,
                        registerUserRequest: registerEffect,
                        saveModelRequest: dummySaveModelRequest
                    )
            )
        }
    ),
    newsReducer.pullback(
        state: /ScreenState.newsState,
        action: /ScreenAction.newsAction,
        environment: { environment in
            return .dev(
                environment: NewsEnvironment(newsRequest: dummyNewsEffect)
            )
        }
    )
)
