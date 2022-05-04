//
//  CancelFeature.swift
//  
//
//  Created by Mikhail Borisov on 07.05.2022.
//

import Core
import ComposableArchitecture

public enum CancelFundAction {
    case confirmCancellingOrder
}

public struct CancelFundState: Equatable {

    public let id = UUID()

    public init() {}
}

public struct CancelFundEnvironment {

    public init() {}
}
