//
//  DetailFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import ComposableArchitecture
import Core

public struct ProgressModel: Decodable {
    let remainAmount: Price
    let originalAmount: Price
}

public struct DetailModel: Decodable {
    let title: String
    let author: String
    let info: String
    let isIncoming: Bool
    let progress: ProgressModel

    static var fixture: Self {
        .init(
            title: "",
            author: "",
            info: "",
            isIncoming: true,
            progress: .init(remainAmount: .init(amount: 0, currency: ""), originalAmount: .init(amount: 0, currency: ""))
        )
    }
}

public struct DetailState: Equatable {

    public static func == (lhs: DetailState, rhs: DetailState) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    /// ID сбора
    let identifier: UUID
    /// Загружен ли сбор
    var isLoaded: Bool = false
    /// Модель
    var detailModel: DetailModel = .fixture

    public init(identifier: UUID) {
        self.identifier = identifier
    }
}

public enum DetailAction {
    case onFavoriteButonnTap
    case onShareButtonTap
    case onAppear
    case onDataLoaded(DetailModel)
    case onActionTapped
    case closeButtonTapped
    case previewTapped(UUID)
}

public struct DetailEnvironment {
    
}

public let detailReducer = Reducer<
DetailState,
DetailAction,
SystemEnvironment<DetailEnvironment>
> { state, action, environment in
    return .none
}
