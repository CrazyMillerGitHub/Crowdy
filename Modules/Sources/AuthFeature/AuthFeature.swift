//
//  AuthFeature.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

import ComposableArchitecture
import Core

/// Стейт-машина для модуля авторизации
public struct AuthState: Equatable {

    var showLogin: Bool
    @BindableState var fullNameValue: String
    @BindableState var passwordValue: String
    @BindableState var confirmPasswordValue: String
    @BindableState var loginValue: String
    var isLoading: Bool

    public static var initialState: Self = .init()

    public init(
        showLogin: Bool = false,
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
}

/// Actions that may happend on authorization screen
public enum AuthAction: BindableAction {
	/// initial event
	case onAppear
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
	/// Authorization completed
	case authCompleted
	/// Authorization Failed
	case authFailed
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
	case .onAppear:
		return .none
	case .logInButtonTapped:
        debugPrint("login: \(state.loginValue), password: \(state.passwordValue)")
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
		switch result {
		case .success(let model):
//			environment
//				.saveModelRequest(environment.storage(), model)
			return .none
		case .failure(let err):
            return Effect(value: .authFailed)
		}
    case .authFailed:
        debugPrint("auth failed")
        fallthrough
	case _:
		return .none
	}
}
.binding()
