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

// MARK: - Fake Data
extension FundDTO {

    public static var fake1: Self {
        .init(
            id: .init(uuidString: "E2E6ABA1-0DEB-43FD-9E40-FAF51A0379BB")!,
            isFavorite: false,
            title: "Круизный лайнер из мусора",
            image: .init(string: "https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2021/04/1200/675/1618865184_RCCL-WonderoftheSeas-CGI02-RET-V3-1-smaller.jpg?ve=1&tl=1")!,
            amountPrecentage: 0.43,
            participants: 12333,
            expirationDate: nil,
            status: .inProgress
        )
    }

    public static var fake2: Self {
        .init(
            id: .init(uuidString: "EB5CFFC0-0340-4B83-B3A6-232CE5C39463")!,
            isFavorite: false,
            title: "Ё-мобиль 2022 года",
            image: .init(string: "https://filearchive.cnews.ru/img/news/2021/02/16/yomobil601.jpg")!,
            amountPrecentage: 0.2,
            participants: 900,
            expirationDate: 1670579130,
            status: .inProgress
        )
    }

    public static var fake3: Self {
        .init(
            id: .init(uuidString: "9FA31E2E-2FDC-472F-B96D-CB42317E6958")!,
            isFavorite: true,
            title: "Собаки, которые любят",
            image: .init(string: "https://www.fund4dogs.ru/images/Events/10-11.04_2021/2019_10_27_SobaKotLyubyat_IMG_9821.jpg")!,
            amountPrecentage: 1.0,
            participants: 10000,
            expirationDate: nil,
            status: .inProgress
        )
    }
}
