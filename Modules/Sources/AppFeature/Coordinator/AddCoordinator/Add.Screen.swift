//
//  Add.Screen.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import AddFeature
import ShareQrFeature

extension AddCoordinator {

    public enum ScreenState: Equatable {
        case add(AddState)
        case fundSelection(FundSelectionState)
        case share(ShareFundState)
    }

    public enum ScreenAction {
        case add(AddAction)
        case fundSelection(FundSelectionAction)
        case share(ShareFundAction)
    }

    typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >

    static let screenReducer: ScreenReducer = .combine(
        addReducer.pullback(
            state: /ScreenState.add,
            action: /ScreenAction.add,
            environment: { _ in
                return .dev(
                    environment: AddEnvironment(
                        createFundRequest: createFundRequest,
                        saveFundRequest: saveFundRequest
                    )
                )
            }
        ),
        fundSelectionReducer.pullback(
            state: /ScreenState.fundSelection,
            action: /ScreenAction.fundSelection,
            environment: { _ in
                return .dev(environment: FundSelectionEnvironment())
            }
        ),
        shareFundReducer.pullback(
            state: /ScreenState.share,
            action: /ScreenAction.share,
            environment: { _ in
                return .dev(
                    environment: ShareFundEnvironment(getFundURLRequest: dummyGetFundURLRequest)
                )
            }
        )
    )
}
