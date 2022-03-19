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

    public init() {}
}

/// Actions that may happend on authorization screen
public enum AuthAction {
	/// initial event
	case onAppear
	/// Log in button was pressed
	case logInButtonTapped(String, String)
	/// Forgot password was tapped
	case forgotButtonTapped
	/// User have been authorized
	case didAuthUser(Result<AuthModel, APIError>)
	/// Authorization completed
	case authCompleted
	/// Authorization Failed
	case authFailed
}

/// Окружение для авторизации
public struct AuthEnvironment {

    /// Запрос на авторизацию пользователя
	var authUserRequest: (JSONDecoder, String, String) -> Effect<AuthModel, APIError>
    /// Запрос на сохранение данных пользователя в бд
	var saveModelRequest: (StorageProtocol, AuthModel) -> Void

    /// Инициализация
    /// - Parameters:
    ///   - authUserRequest: Запрос на авторизацию пользователя
    ///   - saveModelRequest: Запрос на сохранение данных пользователя в бд
	public init(
		authUserRequest: @escaping (JSONDecoder, String, String) -> Effect<AuthModel, APIError>,
		saveModelRequest: @escaping (StorageProtocol, AuthModel) -> Void
	) {
		self.authUserRequest = authUserRequest
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
	case .logInButtonTapped(let login, let password):
		return environment
			.authUserRequest(environment.decoder(), login, password)
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(AuthAction.didAuthUser)
	case .didAuthUser(let result):
		switch result {
		case .success(let model):
			environment
				.saveModelRequest(environment.storage(), model)
			return .none
		case .failure(let err):
			return .none
		}
	case _:
		return .none
	}
}
