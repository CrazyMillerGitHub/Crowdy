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
	@FocusState private var focusedField: Field?

	private enum Field {
		case login
		case password
	}

	public init(store: Store<AuthState, AuthAction>) {
		self.store = store
	}

	public var body: some View {
		return WithViewStore(store) { viewStore in
			VStack(alignment: .leading, spacing: 15) {
				Spacer()
				Text("Добрый день, 👋")
					.font(.title)
                    .bold()
                InputField(
                    placeholder: StringFactory.AuthFeature.login.localizableString,
                    binding: viewStore.binding(\.$loginValue)
                ) {
                    TextField("", text: viewStore.binding(\.$loginValue))
                        .focused($focusedField, equals: .login)
                }
                InputField(
                    placeholder: StringFactory.AuthFeature.login.localizableString,
                    binding: viewStore.binding(\.$passwordValue)
                ) {
                    SecureField("", text: viewStore.binding(\.$passwordValue))
                        .focused($focusedField, equals: .password)
                }
                Text(StringFactory.AuthFeature.forgotPassword.localizableString)
                    .font(.footnote)
                    .foregroundColor(Color.brand.color)
                    .onTapGesture {
                        viewStore.send(.forgotButtonTapped)
                    }
				Spacer()
				Button(StringFactory.AuthFeature.logIn.localizableString) {
					viewStore.send(.logInButtonTapped)
				}
				.buttonStyle(BrandButtonStyle())
			}
            .overlay(content: {
                ProgressView()
                    .opacity(viewStore.isLoading ? 1 : 0)
            })
			.padding([.leading, .trailing])
			.onAppear(perform: {
				viewStore.send(.onAppear)
			})
			.onSubmit {
				switch focusedField {
				case .login:
					focusedField = .password
				case _:
					return
				}
			}
		}
	}
}

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
