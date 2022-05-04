//
//  FundSelectionFeature.swift
//  
//
//  Created by Mikhail Borisov on 04.05.2022.
//

import Core
import Foundation
import ComposableArchitecture


public struct FundSelectionState: Equatable {

    public let id = UUID()

    public init() {}
}

public enum FundSelectionAction {
    case externalFundTapped
    case internalFundTapped
}

public struct FundSelectionEnvironment {

    public init() {}
}

public typealias FundSelectionReducer = Reducer<FundSelectionState, FundSelectionAction ,SystemEnvironment<FundSelectionEnvironment>>

public let fundSelectionReducer = FundSelectionReducer { _, _, _ in
    return .none
}
