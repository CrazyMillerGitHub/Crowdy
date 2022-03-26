//
//  OperationModel.swift
//  
//
//  Created by Mikhail Borisov on 09.03.2022.
//

import Core
import UIKit

public enum Category: String {
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
        return .init(
            title: "Круизный лайнер из мусора",
            category: .travel,
            price: .init(amount: 12, currency: "ru_RU"),
            image: URL(string: "apple.com")!
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
