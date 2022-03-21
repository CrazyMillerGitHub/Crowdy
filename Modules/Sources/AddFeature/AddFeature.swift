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
    @BindableState var catogoryValue: String
    @BindableState var backgroundURL: URL?

    public init(
        titleValue: String = "",
        expirationDateValue: Double? = nil,
        catogoryValue: String = "",
        backgroundURL: URL? = nil
    ) {
        self.titleValue = titleValue
        self.expirationDateValue = expirationDateValue
        self.catogoryValue = catogoryValue
        self.backgroundURL = backgroundURL
    }
}

public enum AddAction: BindableAction {

    case cancelTapped
    case publishTapped
    case binding(BindingAction<AddState>)
    case receiveResponse(Result<FundRequestDTO, APIError>)
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
        debugPrint(state.titleValue, state.expirationDateValue, state.catogoryValue)
        return environment
            .saveFundRequest(environment.storage(), .init())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AddAction.receiveResponse)
    case .receiveResponse(let response):
        guard case let .success(dto) = response else {
            return .none
        }
        debugPrint("Data successfully saved")
    case _:
        break
    }
    return .none
}.binding()
