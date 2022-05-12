//
//  DetailFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import ComposableArchitecture
import UIKit
import Core

public struct Progress: Decodable {

    let remainAmount: Price
    let originalAmount: Price

    public static var fixture = Self(remainAmount: .fixture, originalAmount: .fixture)
}

extension Progress: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.remainAmount == rhs.remainAmount
        && lhs.originalAmount == rhs.originalAmount
    }
}

public struct FundDetail: Decodable, Equatable {

    let id: UUID
    let fund: FundDTO
    let title: String
    var author: String
    let info: String
    let isIncoming: Bool
    let progress: Progress?

    static var fixture: Self {
        .init(
            id: .init(),
            fund: .fixture,
            title: "",
            author: "",
            info: "",
            isIncoming: true,
            progress: .fixture
        )
    }
}

public struct DetailState: Equatable {

    public static func == (lhs: DetailState, rhs: DetailState) -> Bool {
        return lhs.uuid == rhs.uuid
        && lhs.isLoading == rhs.isLoading
        && lhs.detail == rhs.detail
    }

    public let id = UUID()

    /// ID сбора
    let uuid: UUID
    /// Загружен ли сбор
    var isLoading: Bool = true
    /// Модель
    var previews: [URL] = []
    @BindableState var detail: FundDetail = .fixture

    public init(uuid: UUID) {
        self.uuid = uuid
    }
}

public enum DetailAction: BindableAction {
    case onFavoriteButonnTap
    case onShareButtonTap
    case onAppear
    case onDataLoaded(Result<FundDetail, APIError>)
    case onActionTapped
    case shareTapped(URL)
    case previewTapped(URL)
    case binding(BindingAction<DetailState>)
    case closeButtonTapped
    case startCancellingOrder
    case startTransactionOrder(UUID, String, String, URL)
}

public struct DetailEnvironment {

    public var loadDetailRequest: (JSONDecoder, URL, UUID) -> Effect<FundDetail, APIError>

    public init(loadDetailRequest: @escaping (JSONDecoder, URL, UUID) -> Effect<FundDetail, APIError>) {
        self.loadDetailRequest = loadDetailRequest
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
            .loadDetailRequest(
                environment.decoder(),
                environment.remoteConfig().baseURL.appendingPathComponent("detail"),
                state.uuid
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(DetailAction.onDataLoaded)
    case .onDataLoaded(let response):
        guard case .success(let detail) = response else {
            return .none
        }
        state.detail = detail
        state.previews = [URL(string: "https://i.insider.com/622796bbdcce010019a73b34?width=1136&format=jpeg")!]
        state.isLoading = false
        return .none
    case _:
        return .none
    }
}.binding()

#endif
