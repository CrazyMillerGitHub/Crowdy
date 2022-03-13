//
//  DetailFeature.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import ComposableArchitecture
import Core

public struct ProgressModel: Decodable {
    let remainAmount: Price
    let originalAmount: Price
}

public struct DetailModel: Decodable {
    let title: String
    let author: String
    let info: String
    let progress: ProgressModel
}

public struct DetailState: Equatable {
    
}

public enum DetailAction {
    case onFavoriteButonnTap
    case onShareButtonTap
    case onAppear
    case onDataLoaded(DetailModel)
    case onActionTapped
}

public struct DetailEnvironment {
    
}

public let detailReducer = Reducer<
DetailState,
DetailAction,
SystemEnvironment<DetailEnvironment>
> { state, action, environment in
    return .none
}
