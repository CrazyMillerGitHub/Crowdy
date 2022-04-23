//
//  Price.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import Foundation

public struct Price: Decodable {

    public let amount: Decimal
    public let currency: String

    public init(amount: Decimal, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    public var value: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = .init(identifier: currency)
        return currencyFormatter.string(from: amount as NSDecimalNumber) ?? ""
    }

    public static var fixture = Self(
        amount: 1435,
        currency: "RU_ru"
    )
}

extension Price: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.amount == rhs.amount
        && lhs.currency == rhs.currency
    }
}
