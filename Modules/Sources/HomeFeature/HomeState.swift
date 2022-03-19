//
//  HomeState.swift
//  
//
//  Created by Mikhail Borisov on 14.03.2022.
//

import ComposableArchitecture
import Core

public struct HomeState: Equatable {

    public var funds: [Fund]
    public var searchText: String = ""

    public init(funds: [Fund]) {
        self.funds = funds
    }

    public static func ==(lhs: HomeState, rhs: HomeState) -> Bool {
        lhs.funds == rhs.funds
    }
}

extension HomeState {

    static var fixture: HomeState {
        return .init(funds: [.init()])
//        return .init()
//        var initalArr: IdentifiedArrayOf<HomeRowState> = []
//        for _ in 0..<3 {
//            initalArr.append(.init())
//        }
//        return self.init(homeRowStates: initalArr)
    }
}
