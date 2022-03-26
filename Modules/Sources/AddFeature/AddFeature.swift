//
//  AddFeature.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import Foundation
import ComposableArchitecture
import Core

public struct AddState: Equatable {

    @BindableState var titleValue: String
    @BindableState var expirationDateValue: Double?
    @BindableState var categoryValue: String
    @BindableState var backgroundURL: URL?
    var alert: AlertState<AddAction>?

    public init(
        titleValue: String = "",
        expirationDateValue: Double? = nil,
        categoryValue: String = "",
        backgroundURL: URL? = nil
    ) {
        self.titleValue = titleValue
        self.expirationDateValue = expirationDateValue
        self.categoryValue = categoryValue
        self.backgroundURL = backgroundURL
    }

    public static func == (lhs: AddState, rhs: AddState) -> Bool {
        return lhs.titleValue == rhs.titleValue
    }
}

public enum AddAction: BindableAction {

    case cancelTapped
    case publishTapped
    case binding(BindingAction<AddState>)
    case receiveResponse(Result<FundRequestDTO, APIError>)
    case responseFailed
    case alertOkTapped
}

public struct AddEnvironment {

    var saveFundRequest: (CoreDataStorage, FundRequestDTO) -> Effect<FundRequestDTO, APIError>

    public init(saveFundRequest: @escaping (CoreDataStorage, FundRequestDTO) -> Effect<FundRequestDTO, APIError>) {
        self.saveFundRequest = saveFundRequest
    }
}

public typealias AddReducer = Reducer<AddState, AddAction, SystemEnvironment<AddEnvironment>>

public let addReducer = AddReducer { state, action, environment in
    switch action {
    case .publishTapped:
        debugPrint(state.titleValue, state.expirationDateValue, state.categoryValue)
        return environment
            .saveFundRequest(environment.storage(), .init())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AddAction.receiveResponse)
    case .responseFailed:
        state.alert = AlertState(
            title: .init("Ошибка"),
            message: .init("Что-то пошло не так"),
            dismissButton: .default(.init("Хорошо"))
        )
    case .alertOkTapped:
        state.alert = nil
    case .receiveResponse(let response):
        guard case let .success(dto) = response else {
            return Effect(value: .responseFailed)
        }
        debugPrint("Data successfully saved")
    case _:
        break
    }
    return .none
}.binding()
