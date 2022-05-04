//
//  Add.View.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import AuthFeature
import AddFeature
import ShareQrFeature

extension AddCoordinator {

    struct View: SwiftUI.View {

        public typealias AddCoordinatorStore = Store<CoordinatorState, CoordinatorAction>

        let store: AddCoordinatorStore

        public init(store: AddCoordinatorStore) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            TCARouter(store) { screen in
                SwitchStore(screen) {
                    CaseLet(
                        state: /ScreenState.add,
                        action: ScreenAction.add,
                        then: AddView.init
                    )
                    CaseLet(
                        state: /ScreenState.fundSelection,
                        action: ScreenAction.fundSelection,
                        then: FundSelectionView.init
                    )
                    CaseLet(
                        state: /ScreenState.share,
                        action: ScreenAction.share,
                        then: ShareFundView.init
                    )
                }
            }
        }
    }
}
