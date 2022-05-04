//
//  Discovery.Screen.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import ComposableArchitecture
import Core
import NewsFeature
import HomeFeature

extension DiscoveryCoordinator {

    public typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >

    public enum ScreenState: Equatable {

        case news(NewsState)
        case home(HomeState)
        case add(AddCoordinator.CoordinatorState)
        case detail(DetailCoordinator.CoordinatorState)
    }

    public enum ScreenAction {
        case news(NewsAction)
        case home(HomeAction)
        case add(AddCoordinator.CoordinatorAction)
        case detail(DetailCoordinator.CoordinatorAction)
    }

    static let screenReducer: ScreenReducer = .combine(
        newsReducer.pullback(
            state: /ScreenState.news,
            action: /ScreenAction.news,
            environment: { _ in
                return .dev(
                    environment: NewsEnvironment(newsRequest: dummyNewsEffect)
                )
            }
        ),
        homeReducer.pullback(
            state: /ScreenState.home,
            action: /ScreenAction.home,
            environment: { environment in
                return .dev(
                    environment: HomeEnvironment(
                        loadFundsRequest: dummyLoadFundsRequest,
                        updateFavoriteFundRequest: dummyUpdateFavoriteFundRequest
                    )
                )
            }
        ),
        AddCoordinator.coordinatorReducer.pullback(
            state: /ScreenState.add,
            action: /ScreenAction.add,
            environment: { _ in
                return .init()
            }
        ),
        DetailCoordinator.coordinatorReducer.pullback(
            state: /ScreenState.detail,
            action: /ScreenAction.detail,
            environment: { _ in
                return .init()
            }
        )
    )
}

