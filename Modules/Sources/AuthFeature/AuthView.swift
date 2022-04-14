//
//  AuthView.swift
//  
//
//  Created by Mikhail Borisov on 06.03.2022.
//

import DesignSystem
import SwiftUI
import Core
import ComposableArchitecture

/// Экран с авторизацией пользователя
public struct AuthView: View {

    private let store: Store<AuthState, AuthAction>

    public init(store: Store<AuthState, AuthAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                AvailabilityView(viewStore.showLogin) {
                    LoginView(store: store)
                }
                AvailabilityView(!viewStore.showLogin) {
                    RegisterView(store: store)
                }
            }
        }
    }
}

#if DEBUG
struct Preview_AuthView: PreviewProvider {

	static var previews: some View {
		Circle()
		AuthView(
			store: .init(
				initialState: AuthState(),
				reducer: authReducer,
				environment: .dev(
					environment: AuthEnvironment(
                        loginUserRequest: dummyLoginRequest,
                        registerUserRequest: dummyRegisterRequest,
                        saveModelRequest: dummySaveModelRequest
					)
				)
			)
		)
	}
}
#endif
