//
//  AuthModel.swift
//  
//
//  Created by Mikhail Borisov on 07.03.2022.
//

import Core

/// Модель авторизации
public struct AuthModel: Decodable {
	/// Логин
	var login: String
	/// Пароль
	var passwordHash: String
	/// ифнормация о пользователе
	var user: User
}
