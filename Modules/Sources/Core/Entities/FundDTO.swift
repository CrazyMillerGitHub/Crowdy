//
//  Fund.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

import Foundation

public struct FundDTO: Decodable, Equatable, Identifiable {

    public var id: UUID
    public var isFavorite: Bool
    public let title: String
    public let image: URL
    public let amountPrecentage: Double
    public let expirationDate: Double?
    public let participants: Int
    public let status: Status

    public init(
        id: UUID,
        isFavorite: Bool,
        title: String,
        image: URL,
        amountPrecentage: Double,
        participants: Int,
        expirationDate: Double?,
        status: Status
    ) {
        self.isFavorite = isFavorite
        self.title = title
        self.image = image
        self.id = id
        self.amountPrecentage = amountPrecentage
        self.participants = participants
        self.expirationDate = expirationDate
        self.status = status
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
        && lhs.isFavorite == rhs.isFavorite
        && lhs.title == rhs.title
        && lhs.image == rhs.image
        && lhs.amountPrecentage == rhs.amountPrecentage
        && lhs.participants == rhs.participants
        && lhs.expirationDate == rhs.expirationDate
        && lhs.status == rhs.status
    }

    public static var fixture: Self {
        .init(
            id: .init(),
            isFavorite: true,
            title: "Круизный лайнер из мусора",
            image: .init(string: "https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2021/04/1200/675/1618865184_RCCL-WonderoftheSeas-CGI02-RET-V3-1-smaller.jpg?ve=1&tl=1")!,
            amountPrecentage: 0.43,
            participants: 12333,
            expirationDate: nil,
            status: .deliveringGoods
        )
    }
}
