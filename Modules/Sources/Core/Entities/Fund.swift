//
//  Fund.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

import Foundation

public struct Fund: Codable, Equatable, Identifiable {

    public let id: UUID
    public var isFavorite: Bool
    public let title: String
    public let image: URL
    public let amountPrecentage: Double

    public init(id: UUID, isFavorite: Bool, title: String, image: URL, amountPrecentage: Double) {
        self.isFavorite = isFavorite
        self.title = title
        self.image = image
        self.id = id
        self.amountPrecentage = amountPrecentage
    }

    public static var fixture: Self {
        .init(
            id: .init(),
            isFavorite: false,
            title: "Title",
            image: .init(string: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg")!,
            amountPrecentage: 0.43
        )
    }
}
