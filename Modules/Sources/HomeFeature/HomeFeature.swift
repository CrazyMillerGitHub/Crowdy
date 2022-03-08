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

public struct HomeState: Equatable {

	var homeRowState: HomeRowState

	public init(homeRowState: HomeRowState) {
		self.homeRowState = homeRowState
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
