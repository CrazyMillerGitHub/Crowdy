//
//  HomeFeature.swift
//  
//
//  Created by Mikhail Borisov on 09.01.2022.
//

import Foundation
import ComposableArchitecture
import HomeRow
import Core
import SwiftUI

public enum SelectionState: Hashable, Equatable {
    case funds
    case charity
}

public struct HomeState: Equatable {

	var homeRowState: HomeRowState
    @State var selectionState: SelectionState = .funds

    public init(homeRowState: HomeRowState, selectionState: SelectionState) {
		self.homeRowState = homeRowState
//        self.selectionState = selectionState
	}

    public static func == (lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.homeRowState == rhs.homeRowState && lhs.selectionState == rhs.selectionState
    }
}

public struct HomeEnvironment {

	public init() {}
}

public enum HomeAction {
	case homeRowAction(HomeRowAction)
}

public let homeReducer = Reducer<
	HomeState,
	HomeAction,
	SystemEnvironment<HomeEnvironment>
> { state, action, environment in
	return .none
}
