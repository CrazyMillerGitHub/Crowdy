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
    let id: UUID
    let fund: Fund
    let title: String
    var author: String
    let info: String
    let isIncoming: Bool
    let progress: ProgressModel

    static var fixture: Self {
        .init(
            id: .init(),
            fund: .fixture,
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
    case onDataLoaded(Result<DetailModel, APIError>)
    case onActionTapped
    case closeButtonTapped
    case previewTapped(UUID)
}

public struct DetailEnvironment {

    public var loadDetailsRequest: (JSONDecoder, UUID) -> Effect<DetailModel, APIError>

    public init(loadDetailsRequest: @escaping (JSONDecoder, UUID) -> Effect<DetailModel, APIError>) {
        self.loadDetailsRequest = loadDetailsRequest
    }
}

public let detailReducer = Reducer<
DetailState,
DetailAction,
SystemEnvironment<DetailEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment
            .loadDetailsRequest(environment.decoder(), state.identifier)
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(DetailAction.onDataLoaded)
    case .onDataLoaded(let response):
        guard case .success(let model) = response else {
            return .none
        }
        state.detailModel.author = model.author
//        state.detailModel = model
        return .none
    case _:
        return .none
    }
}
