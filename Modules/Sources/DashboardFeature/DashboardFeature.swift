//
//  DashboardFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import Foundation
import Core
import ComposableArchitecture

public struct DashboardState: Equatable {

    var activateFunds: [Fund] = [.fixture]
    var previousFunds: [Fund] = [.fixture]

    public init() {}
}

public enum DashboardAction {
    case onAppear
    case selectFund(UUID)
}

public struct DashboardEnvironment {

    public init() {}
    
}

public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    SystemEnvironment<DashboardEnvironment>
> { _, _, _ in
    return .none
}
