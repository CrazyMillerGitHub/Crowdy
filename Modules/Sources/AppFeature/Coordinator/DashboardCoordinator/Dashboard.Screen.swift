//
//  Dashboard.Screen.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import ComposableArchitecture
import DashboardFeature

extension DashboardCoordinator {

    public struct Environment {}

    public enum ScreenState: Equatable {
        case dashboard(DashboardState)
    }

    public enum ScreenAction {
        case dashboard(DashboardAction)
    }

    typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >

    static let screenReducer: ScreenReducer = .combine(
        dashboardReducer.pullback(
            state: /ScreenState.dashboard,
            action: /ScreenAction.dashboard,
            environment: { environment in
                return .dev(
                    environment: DashboardEnvironment(
                        getUserFundsRequest: dummyGetUserFundsRequest,
                        saveUserFundsRequest: saveUserFundsRequest
                    )
                )
            }
        )
    )
}
