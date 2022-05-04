//
//  Detail.View.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import PreviewFeature
import AddFeature
import PaymentFeature
import DetailFeature
import ShareQrFeature

extension DetailCoordinator {

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
                        state: /ScreenState.preview,
                        action: ScreenAction.preview,
                        then: PreviewView.init
                    )
                    CaseLet(
                        state: /ScreenState.cancel,
                        action: ScreenAction.cancel,
                        then: CancelFundView.init
                    )
                    CaseLet(
                        state: /ScreenState.payment,
                        action: ScreenAction.payment,
                        then: PaymentView.init
                    )
                    CaseLet(
                        state: /ScreenState.detail,
                        action: ScreenAction.detail,
                        then: DetailView.init
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
