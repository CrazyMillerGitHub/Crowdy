//
//  RootView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import HomeFeature
import Core
import DashboardFeature
import SettingsFeature
import AuthFeature
import ComposableArchitecture
import TCACoordinators

public struct RootView: View {
    
    private let store: Store<MainTabCoordinatorState, MainTabCoordinatorAction>
    
    public init(store: Store<MainTabCoordinatorState, MainTabCoordinatorAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: { $0.selectedTab },
                    send: MainTabCoordinatorAction.selectedTabChange
                )
            ) {
                DiscoveryCoordinatorView(store: discoveryCoordinatorStore)
                    .tabItem {
                        Image(systemName: "star.square.fill")
                        Text(StringFactory.Tab.discovery.localizableString)
                    }
                    .tag(MainTabCoordinatorState.Tab.discovery)
                DashboardCoordinatorView(store: dashboardCoordinatorStore)
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text(StringFactory.Tab.dashboard.localizableString)
                    }
                    .tag(MainTabCoordinatorState.Tab.dashboard)
               SettingsCoordinatorView(store: settingsCoordinatorStore)
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text(StringFactory.Tab.settings.localizableString)
                    }
                    .tag(MainTabCoordinatorState.Tab.settings)
            }
        }
    }
}

extension RootView {

    private var discoveryCoordinatorStore: Store<
        DiscoveryCoordinatorState,
        DiscoveryCoordinatorAction
    > {
        store.scope(
          state: \MainTabCoordinatorState.discovery,
          action: MainTabCoordinatorAction.discovery
        )
    }

    private var dashboardCoordinatorStore: Store<
        DashboardCoordinatorState,
        DashboardCoordinatorAction
    > {
        store.scope(
          state: \MainTabCoordinatorState.dashboard,
          action: MainTabCoordinatorAction.dashboard
        )
    }

    private var settingsCoordinatorStore: Store<
        SettingsCoordinatorState,
        SettingsCoordinatorAction
    > {
        store.scope(
          state: \MainTabCoordinatorState.settings,
          action: MainTabCoordinatorAction.settings
        )
    }
}

#if DEBUG
struct RootView_Preview: PreviewProvider {

	static var previews: some View {
        RootView(store:
                .init(
                    initialState: .initialState,
                    reducer: mainTabCoordinatorReducer,
                    environment: .init()
                )
        )
	}
}
#endif
