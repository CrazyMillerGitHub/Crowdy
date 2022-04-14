//
//  HomeState.swift
//  
//
//  Created by Mikhail Borisov on 14.03.2022.
//

import ComposableArchitecture
import Core

public struct HomeState: Equatable {

    public var funds: [FundDTO]
    var isLoading = true
    @BindableState var searchText = ""

    public var searchResults: [FundDTO] {
        guard !searchText.isEmpty else {
            return funds
        }
        return funds.filter { fund in
            fund.title.lowercased().contains(searchText.lowercased())
        }
    }

    public init(funds: [FundDTO]) {
        self.funds = funds
    }

    public static func ==(lhs: HomeState, rhs: HomeState) -> Bool {
        lhs.funds == rhs.funds
        && lhs.searchText == rhs.searchText
    }
}

extension HomeState {

    static var fixture: HomeState {
        return .init(funds: [.fixture, .fixture, .fixture])
//        return .init()
//        var initalArr: IdentifiedArrayOf<HomeRowState> = []
//        for _ in 0..<3 {
//            initalArr.append(.init())
//        }
//        return self.init(homeRowStates: initalArr)
    }
}
