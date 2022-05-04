//
//  Dashboard.View.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import DashboardFeature

extension DashboardCoordinator {

    struct View: SwiftUI.View {

        public typealias DashboardStore = Store<CoordinatorState, CoordinatorAction>

        let store: DashboardStore

        public init(store: DashboardStore) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            TCARouter(store) { screen in
                SwitchStore(screen) {
                    CaseLet(
                        state: /ScreenState.dashboard,
                        action: ScreenAction.dashboard,
                        then: DashboardView.init
                    )
                }
            }
        }
    }
}
