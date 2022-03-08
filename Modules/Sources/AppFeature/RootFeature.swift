//
//  RootFeature.swift
//  
//
//  Created by Mikhail Borisov on 07.01.2022.
//

import ComposableArchitecture
import HomeRow
import Core
import NewsFeature

public struct RootState {

	public init(homeRowState: HomeRowState = HomeRowState(), newsState: NewsState = NewsState()) {
		self.homeRowState = homeRowState
		self.newsState = newsState
	}

	public init() {
		self.homeRowState = HomeRowState()
		self.newsState = NewsState()
	}

	public var homeRowState: HomeRowState
	public var newsState: NewsState
}

public enum RootAction {
	case homeRowAction(HomeRowAction)
	case newsAction(HomeRowAction)
}

public struct RootEnvironment {

	public init() {}
}

public let rootReducer = Reducer<
	RootState,
	RootAction,
	SystemEnvironment<RootEnvironment>
>.combine(
	homeRowReducer.pullback(
		state: \.homeRowState,
		action: /RootAction.homeRowAction,
		environment: { _ in .dev(
			environment: HomeRowEnvironment(
				crowdfundingId: { 4 },
				crowdfundingRequest: dummyCrowdfundingEffect,
				mediaContentRequest: dummyMediaContentEffect,
				updateFavouriteRequest: dummyUpdateFavouriteEffect
			)
		)
		}
	)
)
