//
//  Status.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import Foundation

public enum Status: String, Decodable {
    case `none`
    case cancelled
    case inProgress
    case finished
    case deliveringGoods
}
