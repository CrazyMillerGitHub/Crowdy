//
//  OperationModel.swift
//  
//
//  Created by Mikhail Borisov on 09.03.2022.
//

import Core
import UIKit

public enum Category: String, CaseIterable {
    case travel
    case electronic
    case charity
}

public struct OperationModel {

    let title: String
    let category: Category
    let price: Price
    let image: URL

    public static var fixture: Self {
        let title = [
            "Круизный лайнер из мусора",
            "Фонд помощи беженцам донбасса",
            "Подшибник для поезда"
        ]
        return .init(
            title: title.randomElement() ?? "",
            category: Category.allCases.randomElement() ?? .charity,
            price: .init(amount: Decimal(Int.random(in: 0..<1000)), currency: "ru_RU"),
            image: URL(string: "https://bsmp-bel.ru/images/help.jpg")!
        )
    }
}

extension OperationModel: Equatable, Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(category)
        hasher.combine(image)
    }
}
