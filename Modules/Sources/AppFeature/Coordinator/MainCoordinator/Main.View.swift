//
//  MainCoordinator.View.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import Core
import DesignSystem

extension MainCoordinator {
    
    public struct View: SwiftUI.View {
        
        let store: Store<MainCoordinator.CoordinatorState, MainCoordinator.CoordinatorAction>
        
        public init(store: Store<MainCoordinator.CoordinatorState, MainCoordinator.CoordinatorAction>) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                TabView() {
                    DiscoveryCoordinator.View(
                        store: store.scope(
                            state: \MainCoordinator.CoordinatorState.discovery,
                            action: MainCoordinator.CoordinatorAction.discovery
                        )
                    )
                    .tabItem {
                        Image(systemName: "star.square.fill")
                        Text(StringFactory.Tab.discovery.localizableString)
                    }
                    DashboardCoordinator.View(
                        store: store.scope(
                            state: \MainCoordinator.CoordinatorState.dashboard,
                            action: MainCoordinator.CoordinatorAction.dashboard
                        )
                    )
                        .tabItem {
                            Image(systemName: "chart.bar.fill")
                            Text(StringFactory.Tab.dashboard.localizableString)
                        }
                    SettingsCoordinator.View(
                        store: store.scope(
                            state: \MainCoordinator.CoordinatorState.settings,
                            action: MainCoordinator.CoordinatorAction.settings
                        )
                    )
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text(StringFactory.Tab.settings.localizableString)
                    }
                }
                .accentColor(TokenName.brand.color)
            }
        }
    }
}
