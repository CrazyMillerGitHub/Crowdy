//
//  NewsFeature.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

#if !APPCLIP

import Foundation
import Core
import ComposableArchitecture

public struct NewsState: Equatable {

    public let id = UUID()

	public init() {}

	var news: [NewsModel] = []
}

public enum NewsAction {
    /// When view appeared
	case onAppear
    /// When data loaded
    case dataLoaded(Result<[NewsModel], APIError>)
    /// When user tapped
	case continueButtonTapped
}

public struct NewsEnvironment {

	var newsRequest: (JSONDecoder) -> Effect<[NewsModel], APIError>

	public init(newsRequest: @escaping (JSONDecoder) -> Effect<[NewsModel], APIError>) {
		self.newsRequest = newsRequest
	}
}

public let newsReducer = Reducer<
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
    default:
        return .none
	}
}

#endif
