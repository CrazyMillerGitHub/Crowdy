//
//  ShareFundFeature.swift
//  
//
//  Created by Mikhail Borisov on 06.05.2022.
//

import Foundation
import ComposableArchitecture
import Core
import DesignSystem

public struct ShareFundState: Equatable, Identifiable {

    public let id: UUID = UUID()

    var alert: AlertState<ShareFundAction>?
    let fundId: UUID
    var isLoading = true
    var url: String = ""
    @BindableState
    var showShareSheet = false

    public init(fundId: UUID) {
        self.fundId = fundId
    }

    public static func == (lhs: ShareFundState, rhs: ShareFundState) -> Bool {
        return lhs.fundId == rhs.fundId
        && lhs.isLoading == rhs.isLoading
        && lhs.alert?.id == rhs.alert?.id
        && lhs.showShareSheet == rhs.showShareSheet
    }
}

public enum ShareFundAction: BindableAction {
    case onAppear
    case urlLoaded(Result<String, APIError>)
    case shareButtonTapped
    case saveButtonTapped
    case onCloseTapped
    case urlLoadFailed
    case okTapped
    case binding(BindingAction<ShareFundState>)
}

public struct ShareFundEnvironment {

    var getFundURLRequest: () -> Effect<String, APIError>

    public init(getFundURLRequest: @escaping () -> Effect<String, APIError>) {
        self.getFundURLRequest = getFundURLRequest
    }
}

public typealias ShareFundReducer = Reducer<ShareFundState, ShareFundAction, SystemEnvironment<ShareFundEnvironment>>

public let shareFundReducer = ShareFundReducer { state, action, environment in
    switch action {
    case .onAppear:
        return environment
            .getFundURLRequest()
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ShareFundAction.urlLoaded)
    case .urlLoaded(let result):
        guard case .success(let url) = result else {
            return Effect(value: .urlLoadFailed)
        }
        state.isLoading = false
        state.url = url
    case .urlLoadFailed:
        state.alert = AlertState(
            title: .init(StringFactory.Alert.error.localizableString),
            message: .init(StringFactory.Alert.somethingWentWrong.localizableString),
            dismissButton: .default(.init(StringFactory.Alert.ok.localizableString))
        )
    case .shareButtonTapped:
        state.showShareSheet = true
    case .okTapped:
        state.alert = nil
    case _:
        break
    }
    return .none
}.binding()
