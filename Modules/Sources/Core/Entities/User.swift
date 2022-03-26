//
//  User.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

/// Модель пользователя
public struct User: Decodable {

    public let uuid: Int64

    public init(uuid: Int64) {
        self.uuid = uuid
    }

    public static var fixture: Self = .init(uuid: 1)
}
