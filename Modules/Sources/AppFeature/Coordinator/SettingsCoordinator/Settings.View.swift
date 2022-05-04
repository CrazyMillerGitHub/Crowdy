//
//  Settings.View.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import SettingsFeature
import EditProfileFeature
import SwiftUI

extension SettingsCoordinator {

    public struct View: SwiftUI.View {

        public typealias SettingsStore = Store<CoordinatorState, CoordinatorAction>

        let store: SettingsStore

        public init(store: SettingsStore) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            TCARouter(store) { screen in
                SwitchStore(screen) {
                    CaseLet(
                        state: /ScreenState.settings,
                        action: ScreenAction.settings,
                        then: SettingsView.init
                    )
                    CaseLet(
                        state: /ScreenState.editProfile,
                        action: ScreenAction.editProfile,
                        then: EditProfileView.init
                    )
                }
            }
        }
    }

}
