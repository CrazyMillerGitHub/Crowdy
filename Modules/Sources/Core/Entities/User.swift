//
//  User.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import Foundation

/// Модель пользователя
public struct UserDTO: Decodable {

    public var firstName: String

    public var lastName: String

    public var middleName: String

    public var uuid: UUID

    public var email: String

    public var fullName: String {
        [firstName, lastName, middleName].joined(separator: " ")
    }

    public init(
        uuid: UUID,
        firstName: String,
        lastName: String,
        middleName: String,
        email: String
    ) {
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.email = email
    }

    public static var fixture: Self = .init(uuid: .init(), firstName: "Михаил", lastName: "Борисов", middleName: "", email: "dsgnmike@gmail.com")
}
