//
//  App.View.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI

extension AppCoordinator {

    public struct View: SwiftUI.View {

        public typealias Store = ComposableArchitecture.Store<CoordinatorState, CoordinatorAction>

        public let store: Store

        public init(store: Store) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            TCARouter(store) { screen in
                SwitchStore(screen) {
                    CaseLet(
                        state: /AppCoordinator.ScreenState.splash,
                        action: AppCoordinator.ScreenAction.splash,
                        then: Splash.View.init
                    )
                    CaseLet(
                        state: /AppCoordinator.ScreenState.main,
                        action: AppCoordinator.ScreenAction.main,
                        then: MainCoordinator.View.init
                    )
                    CaseLet(
                        state: /AppCoordinator.ScreenState.onboarding,
                        action: AppCoordinator.ScreenAction.onboarding,
                        then: OnboardingCoordinator.View.init
                    )
                }
            }
        }
    }
}
