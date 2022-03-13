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
    let image: Data

    public static var fixture: Self {
        return .init(
            title: "Best pen in the world",
            category: .electronic,
            price: .init(amount: 12, currency: "ru_RU"),
            image: UIImage(named: "settings_test", in: .main, with: nil)!.pngData()!
        )
    }
}
