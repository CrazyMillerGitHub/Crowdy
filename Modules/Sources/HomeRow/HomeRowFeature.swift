//
//  HomeRowFeature.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import Foundation
import Core
import ComposableArchitecture
import UIKit

public struct HomeRowState: Equatable {
	var crowdfunding: HomeRowModel = HomeRowModel.fixture
	var isLoaded: Bool = false
	var contentImage: UIImage = UIImage(systemName: "circle")!
}

public enum HomeRowAction {
	case onAppear
	case didLoadData(Result<HomeRowModel, APIError>)
	case didLoadImage(Result<UIImage, APIError>)
	case favouriteButtonTapped
	case didUpdateFavourite(Result<HomeRowModel, APIError>)
	case rowTapped
}

public struct HomeRowEnvironment {
	var crowdfundingId: () -> Int
	var crowdfundingRequest: (JSONDecoder, Int) -> Effect<HomeRowModel, APIError>
	var mediaContentRequest: (JSONDecoder, URL?) -> Effect<UIImage, APIError>
	var updateFavouriteRequest: (JSONDecoder, Int, Bool) -> Effect<HomeRowModel, APIError>
}

let homeRowReducer = Reducer<
	HomeRowState,
	HomeRowAction,
	SystemEnvironment<HomeRowEnvironment>
> { state, action, environment in
	switch action {
	case .onAppear:
		return environment
			.crowdfundingRequest(environment.decoder(), environment.crowdfundingId())
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(HomeRowAction.didLoadData)
	case .didLoadData(let result):
		switch result {
		case .success(let crowdfunding):
			state.crowdfunding = crowdfunding
			state.isLoaded = true
			return environment
				.mediaContentRequest(environment.decoder(), crowdfunding.mediaUrl)
				.receive(on: environment.mainQueue())
				.catchToEffect()
				.map(HomeRowAction.didLoadImage)
		case .failure(let err):
			assertionFailure("Error: \(err.localizedDescription)")
			return .none
		}
	case .didLoadImage(let result):
		switch result {
		case .success(let contentImage):
			state.contentImage = contentImage
			return .none
		case .failure(let err):
			assertionFailure("Error: \(err.localizedDescription)")
			return .none
		}
	case .favouriteButtonTapped:
		return environment
			.updateFavouriteRequest(environment.decoder(), environment.crowdfundingId(), !state.crowdfunding.favourite)
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(HomeRowAction.didUpdateFavourite)
	case .didUpdateFavourite(let result):
		switch result {
		case .success(let crowdfunding):
			state.crowdfunding = crowdfunding
			return .none
		case .failure(let err):
			assertionFailure("Error: \(err.localizedDescription)")
			return .none
		}
	case .rowTapped:
		assertionFailure("Something should Happen")
		return .none
	}
}
