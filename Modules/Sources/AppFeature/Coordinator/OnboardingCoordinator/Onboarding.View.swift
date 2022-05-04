//
//  Onboarding.View.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import SwiftUI
import AuthFeature
import OnboardingFeature
import ForgetFeature
import ComposableArchitecture

extension OnboardingCoordinator {
    
    public struct View: SwiftUI.View {
        
        let store: Store<OnboardingCoordinator.CoordinatorState, OnboardingCoordinator.CoordinatorAction>
        
        public init(
            store: Store<OnboardingCoordinator.CoordinatorState, OnboardingCoordinator.CoordinatorAction>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            NavigationView {
                TCARouter(store) { screen in
                    SwitchStore(screen) {
                        CaseLet(
                            state: /ScreenState.auth,
                            action: ScreenAction.auth,
                            then: AuthView.init
                        )
                        CaseLet(
                            state: /ScreenState.onboarding,
                            action: ScreenAction.onboarding,
                            then: OnboardingView.init
                        )
                        CaseLet(
                            state: /ScreenState.forget,
                            action: ScreenAction.forget,
                            then: ForgetView.init
                        )
                    }
                }
            }
        }
    }
}
