//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import SwiftUI
import ComposableArchitecture
import NewsFeature
import HomeFeature

extension DiscoveryCoordinator {
    
    public struct View: SwiftUI.View {
        
        let store: Store<CoordinatorState, CoordinatorAction>
        
        public init(
            store: Store<CoordinatorState, CoordinatorAction>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            NavigationView {
                TCARouter(store) { screen in
                    SwitchStore(screen) {
                        CaseLet(
                            state: /ScreenState.news,
                            action: ScreenAction.news,
                            then: NewsView.init
                        )
                        CaseLet(
                            state: /ScreenState.home,
                            action: ScreenAction.home,
                            then: HomeView.init
                        )
                        CaseLet(
                            state: /ScreenState.add,
                            action: ScreenAction.add,
                            then: AddCoordinator.View.init
                        )
                        CaseLet(
                            state: /ScreenState.detail,
                            action: ScreenAction.detail,
                            then: DetailCoordinator.View.init
                        )
                    }
                }
            }
        }
    }
}
