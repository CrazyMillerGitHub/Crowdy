//
//  Order.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import Foundation

public struct OrderDTO {

    var title: String
    var amount: NSDecimalNumber

    public init(title: String, amount: NSDecimalNumber) {
        self.title = title
        self.amount = amount
    }
}
