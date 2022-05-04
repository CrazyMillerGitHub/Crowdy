//
//  User.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

/// Модель пользователя
public struct UserDTO: Decodable {

    public let uuid: Int

    public init(uuid: Int) {
        self.uuid = uuid
    }

    public static var fixture: Self = .init(uuid: 1)
}
