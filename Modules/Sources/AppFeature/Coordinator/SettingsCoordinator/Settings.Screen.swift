//
//  Settings.Screen.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import ComposableArchitecture
import SettingsFeature
import EditProfileFeature

extension SettingsCoordinator {

    public typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >

    public enum ScreenState: Equatable, Identifiable {

        case settings(SettingsState)
        case editProfile(EditProfileState)

        public var id: UUID {
            switch self {
            case .settings(let state):
                return state.id
            case .editProfile(let state):
                return state.id
            }
        }
    }

    public enum ScreenAction {
        case settings(SettingsAction)
        case editProfile(EditProfileAction)
    }
    
    static let screenReducer: ScreenReducer = .combine(
        settingsReducer.pullback(
            state: /ScreenState.settings,
            action: /ScreenAction.settings,
            environment: { environment in
                return .dev(
                    environment: SettingsEnvironment(
                        loadUserRequest: dummyLoadUserRequest,
                        loadOperationsRequest: dummyLoadUserOperationsRequest
                    )
                )
            }
        ),
        editProfileReducer.pullback(
            state: /ScreenState.editProfile,
            action: /ScreenAction.editProfile,
            environment: { _ in
                return .dev(
                    environment: EditProfileEnvironment(loadUserRequest: dummyEditProfileRequest)
                )
            }
        )
    )
}
