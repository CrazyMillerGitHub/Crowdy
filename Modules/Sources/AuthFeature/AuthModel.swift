//
//  AuthModel.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

import Core
import ComposableArchitecture

/// Модель авторизации
public struct AuthModel: Decodable {
	/// Логин
	var login: String
	/// Пароль
	var passwordHash: String
	/// ифнормация о пользователе
	var user: User
    @BindableState var shouldRegister = false
}

public struct LoginRequest: Encodable {
    let user: String
    let password: String
}

public struct RegisterRequest: Encodable {
    let fullName: String
    let email: String
    let password: String
    let confirmPassword: String
}
