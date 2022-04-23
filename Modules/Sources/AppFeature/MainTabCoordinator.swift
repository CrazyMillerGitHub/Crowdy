//
//  MainTabCoordinatorState.swift
//  
//
//  Created by Mikhail Borisov on 18.03.2022.
//

#if !APPCLIP

import Foundation
import ComposableArchitecture

public struct MainTabCoordinatorState: Equatable {

    public static let initialState: Self = .init(
        dashboard: .initialState,
        discovery: .initialState,
        settings: .initialState
    )

    public var dashboard: DashboardCoordinatorState
    public var discovery: DiscoveryCoordinatorState
    public var settings: SettingsCoordinatorState

    public enum Tab {
        case discovery
        case dashboard
        case settings
    }

    var selectedTab: Tab = .discovery
}

public enum MainTabCoordinatorAction {
    case dashboard(DashboardCoordinatorAction)
    case discovery(DiscoveryCoordinatorAction)
    case settings(SettingsCoordinatorAction)
    case selectedTabChange(MainTabCoordinatorState.Tab)
}

public struct MainTabCoordinatorEnvironment {

    public init() {}
}

public typealias MainTabCoordinatorReducer = Reducer<
    MainTabCoordinatorState,
    MainTabCoordinatorAction,
    MainTabCoordinatorEnvironment
>

public let mainTabCoordinatorReducer: MainTabCoordinatorReducer = .combine(
    discoveryCoordinatorReducer
        .pullback(
            state: \MainTabCoordinatorState.discovery,
            action: /MainTabCoordinatorAction.discovery,
            environment: { _ in .init() }
        ),
    dashboardCoordinatorReducer
        .pullback(
            state: \MainTabCoordinatorState.dashboard,
            action: /MainTabCoordinatorAction.dashboard,
            environment: { _ in .init() }
        ),
    settingsCoordinatorReducer
        .pullback(
            state: \MainTabCoordinatorState.settings,
            action: /MainTabCoordinatorAction.settings,
            environment: { _ in .init() }
        )
)

#endif
