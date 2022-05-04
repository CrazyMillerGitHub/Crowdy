//
//  DashboardFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import Foundation
import Core
import CoreData
import ComposableArchitecture
import SwiftUI

public struct DashboardState: Equatable {

    var activateFunds: [UserFund] = []

    var previousFunds: [UserFund] = []

    var isLoading: Bool = true
    
    public let id = UUID()

    public init() {}

    public static func == (lhs: DashboardState, rhs: DashboardState) -> Bool {
        lhs.activateFunds.count == rhs.activateFunds.count
    }
}

public enum DashboardAction {
    case onAppear
    case fundsLoaded(Result<[FundDTO], APIError>)
    case fundsSaved(Result<[UserFund], StorageError>)
    case fundsFailed
    case selectFund(UUID)
}

public struct DashboardEnvironment {

    var getUserFundsRequest: (JSONDecoder, JSONEncoder, URL, UserFundsRequest) -> Effect<[FundDTO], APIError>
    var saveUserFundsRequest: (PersistenceController, [FundDTO]) -> Effect<[UserFund], StorageError>

    public init(
        getUserFundsRequest: @escaping (JSONDecoder, JSONEncoder, URL, UserFundsRequest) -> Effect<[FundDTO], APIError>,
        saveUserFundsRequest: @escaping (PersistenceController, [FundDTO]) -> Effect<[UserFund], StorageError>
    ) {
        self.getUserFundsRequest = getUserFundsRequest
        self.saveUserFundsRequest = saveUserFundsRequest
    }
    
}

public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    SystemEnvironment<DashboardEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment
            .getUserFundsRequest(
                environment.decoder(),
                environment.encoder(),
                environment.remoteConfig().baseURL,
                .init(userId: environment.currentUser().uuid)
            )
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(DashboardAction.fundsLoaded)
    case .fundsLoaded(let response):
        guard case .success(let funds) = response else {
            return Effect(value: .fundsFailed)
        }
        return environment
            .saveUserFundsRequest(environment.storage(), funds)
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(DashboardAction.fundsSaved)
    case .fundsSaved(let response):
        guard case .success(let funds) = response else {
            return Effect(value: .fundsFailed)
        }
        state.isLoading = false
        fallthrough
    case _:
        return .none
    }
}

#endif
