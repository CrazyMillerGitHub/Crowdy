//
//  Fund.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

import Foundation

public struct Fund: Codable, Equatable, Identifiable {

    public let id: UUID = UUID()

    public var isFavorite: Bool = true
    public var isLoaded: Bool = true

    public init() {}
}
