//
//  NewsFeature.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import Foundation
import Core
import ComposableArchitecture

struct NewsState: Equatable {
	var news: [NewsModel] = []
}

enum NewsAction {
	case onAppear
    case dataLoaded(Result<[NewsModel], APIError>)
	case continueButtonTapped
}

struct NewsEnvironment {
	var newsRequest: (JSONDecoder) -> Effect<[NewsModel], APIError>
}

let newsReducer = Reducer<
	NewsState,
	NewsAction,
	SystemEnvironment<NewsEnvironment>
> { state, action, environment in
	switch action {
	case .onAppear:
		return environment
			.newsRequest(environment.decoder())
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(NewsAction.dataLoaded)
	case .dataLoaded(let result):
		switch result {
		case .failure(_):
			break
		case .success(let news):
			state.news = news
		}
		return .none
	case .continueButtonTapped:
		return .none
	}
}
