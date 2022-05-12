//
//  AuthFeature.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

#if !APPCLIP

import ComposableArchitecture
import Core
import SwiftUI

/// Стейт-машина для модуля авторизации
public struct AuthState: Equatable {

    var showLogin: Bool
    @BindableState var fullNameValue: String
    @BindableState var passwordValue: String
    @BindableState var confirmPasswordValue: String
    @BindableState var loginValue: String
    var alert: AlertState<AuthAction>?
    var isLoading: Bool

    public let id = UUID()

    var loginIsReady: Bool {
        !loginValue.isEmpty
        && !passwordValue.isEmpty
        && Predicate.email.evaluate(loginValue)
        && Predicate.password.evaluate(passwordValue)
        && (showLogin || confirmPasswordValue == passwordValue)
    }

    public init(
        showLogin: Bool,
        fullNameValue: String = "",
        loginValue: String = "",
        passwordValue: String = "",
        confirmPasswordValue: String = "",
        isLoading: Bool = false
    ) {
        self.showLogin = showLogin
        self.fullNameValue = fullNameValue
        self.loginValue = loginValue
        self.passwordValue = passwordValue
        self.confirmPasswordValue = confirmPasswordValue
        self.isLoading = isLoading
    }

    public static func == (lhs: AuthState, rhs: AuthState) -> Bool {
        return lhs.isLoading == rhs.isLoading
        && lhs.alert?.id == rhs.alert?.id
        && lhs.fullNameValue == rhs.fullNameValue
        && lhs.isLoading == rhs.isLoading
        && lhs.loginValue == rhs.loginValue
        && lhs.confirmPasswordValue == rhs.confirmPasswordValue
        && lhs.passwordValue == rhs.passwordValue
    }
}

/// Actions that may happend on authorization screen
public enum AuthAction: BindableAction {
	/// Log in button was pressed
	case logInButtonTapped
    /// Register button Tapped
    case registerButtonTapped
    /// Login button Tapped
    case areYouRegisteredTapped
	/// Forgot password was tapped
	case forgotButtonTapped
	/// User have been authorized
	case didAuthUser(Result<AuthModel, APIError>)
    /// Show alert that something went wrong
    case showAlert
	/// Authorization completed
	case authCompleted
	/// Authorization Failed
	case authFailed
    case alertOkTapped
    /// Binding
    case binding(BindingAction<AuthState>)
}

/// Окружение для авторизации
public struct AuthEnvironment {

    /// Запрос на авторизацию пользователя
	var loginUserRequest: (JSONDecoder, JSONEncoder, URL, LoginRequest) -> Effect<AuthModel, APIError>
    /// Зарегистрировать пользователя
    var registerUserRequest: (JSONDecoder, JSONEncoder, URL, RegisterRequest) -> Effect<AuthModel, APIError>
    /// Запрос на сохранение данных пользователя в бд
	var saveModelRequest: (StorageProtocol, AuthModel) -> Void

    /// Инициализация
    /// - Parameters:
    ///   - authUserRequest: Запрос на авторизацию пользователя
    ///   - registerUserRequest: Зарегистрировать пользователя
    ///   - saveModelRequest: Запрос на сохранение данных пользователя в бд
	public init(
		loginUserRequest: @escaping(JSONDecoder, JSONEncoder, URL, LoginRequest) -> Effect<AuthModel, APIError>,
        registerUserRequest: @escaping (JSONDecoder, JSONEncoder, URL, RegisterRequest) -> Effect<AuthModel, APIError>,
		saveModelRequest: @escaping (StorageProtocol, AuthModel) -> Void
	) {
		self.loginUserRequest = loginUserRequest
        self.registerUserRequest = registerUserRequest
		self.saveModelRequest = saveModelRequest
	}
}

/// Reducer для авторизации
public let authReducer = Reducer<
	AuthState,
	AuthAction,
	SystemEnvironment<AuthEnvironment>
> { state, action, environment in
	switch action {
	case .logInButtonTapped:
        state.isLoading = true
		return environment
            .loginUserRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL.appendingPathComponent("auth"),
                .init(user: state.loginValue, password: state.passwordValue)
            )
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(AuthAction.didAuthUser)
    case .registerButtonTapped:
        return environment
            .registerUserRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL.appendingPathComponent("auth"),
                .init(
                    fullName: state.fullNameValue,
                    email: state.loginValue,
                    password: state.passwordValue,
                    confirmPassword: state.confirmPasswordValue
                )
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AuthAction.didAuthUser)
	case .didAuthUser(let result):
        state.isLoading = false
        guard case .success(let response) = result else {
            return Effect(value: .authFailed)
        }
        var storage = environment.storage()
        storage.update(user: response.user)
        return Effect(value: .authCompleted)
    case .authFailed:
        state.alert = AlertState(
            title: .init(StringFactory.Alert.error.localizableString),
            message: .init(StringFactory.Alert.somethingWentWrong.localizableString),
            dismissButton: .default(.init(StringFactory.Alert.ok.localizableString))
        )
        return .none
    case .alertOkTapped:
        state.alert = nil
        return .none
	case _:
		return .none
	}
}
.binding()

#endif
