//
//  AddFeature.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

#if !APPCLIP

import Foundation
import ComposableArchitecture
import Core

public struct AddState: Equatable {

    @BindableState var titleValue: String
    @BindableState var expirationDateValue: String
    @BindableState var categoryValue: String
    @BindableState var infoValue: String
    @BindableState var backgroundURL: URL?
    @BindableState var isHiddenFund: Bool
    var alert: AlertState<AddAction>?
    public let id = UUID()

    public init(
        titleValue: String = "",
        expirationDateValue: String = "",
        categoryValue: String = "",
        infoValue: String = "",
        isHiddenFund: Bool = false,
        backgroundURL: URL? = nil
    ) {
        self.titleValue = titleValue
        self.expirationDateValue = expirationDateValue
        self.categoryValue = categoryValue
        self.backgroundURL = backgroundURL
        self.isHiddenFund = isHiddenFund
        self.infoValue = infoValue
    }

    var requestIsReady: Bool {
        return !titleValue.isEmpty && !categoryValue.isEmpty
    }

    public static func == (lhs: AddState, rhs: AddState) -> Bool {
        return lhs.titleValue == rhs.titleValue
        && lhs.expirationDateValue == rhs.expirationDateValue
        && lhs.categoryValue == rhs.categoryValue
        && lhs.alert?.id == rhs.alert?.id
    }
}

public enum AddAction: BindableAction {

    case cancelTapped
    case publishTapped
    case binding(BindingAction<AddState>)
    case receiveResponse(Result<FundRequestDTO, APIError>)
    case saveFund(FundRequestDTO)
    case receiveSaveResponse(Result<FundRequestDTO, StorageError>)
    case responseFailed
    case alertOkTapped
    case saveSuccess(UUID)
}

public struct AddEnvironment {

    var createFundRequest: (JSONDecoder, FundRequestDTO) -> Effect<FundRequestDTO, APIError>
    var saveFundRequest: (PersistenceController, FundRequestDTO) -> Effect<FundRequestDTO, StorageError>

    public init(
        createFundRequest: @escaping (JSONDecoder, FundRequestDTO) -> Effect<FundRequestDTO, APIError>,
        saveFundRequest: @escaping (PersistenceController, FundRequestDTO) -> Effect<FundRequestDTO, StorageError>
    ) {
        self.createFundRequest = createFundRequest
        self.saveFundRequest = saveFundRequest
    }
}

public typealias AddReducer = Reducer<AddState, AddAction, SystemEnvironment<AddEnvironment>>

public let addReducer = AddReducer { state, action, environment in
    switch action {
    case .publishTapped:
        return environment
            .createFundRequest(
                environment.decoder(),
                .init(id: .init(),
                      title: state.titleValue,
                      expirationDate: -1,
                      creatorId: environment.currentUser().uuid,
                      category: 0
                     )
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AddAction.receiveResponse)
    case .responseFailed:
        state.alert = AlertState(
            title: .init(StringFactory.Alert.error.localizableString),
            message: .init(StringFactory.Alert.somethingWentWrong.localizableString),
            dismissButton: .default(.init(StringFactory.Alert.ok.localizableString))
        )
    case .alertOkTapped:
        state.alert = nil
    case .receiveResponse(let response):
        guard case let .success(dto) = response else {
            return Effect(value: .responseFailed)
        }
        return Effect(value: .saveFund(dto))
    case .saveFund(let dto):
        return environment
            .saveFundRequest(environment.storage(), dto)
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AddAction.receiveSaveResponse)
    case .receiveSaveResponse(let response):
        guard case let .success(dto) = response else {
            return Effect(value: .responseFailed)
        }
        return Effect(value: .saveSuccess(.init()))
            .delay(for: 0.5, scheduler: environment.mainQueue())
            .eraseToEffect()
    case _:
        break
    }
    return .none
}
    .binding()

#endif
