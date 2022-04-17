//
//  ForgetView.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

import SwiftUI
import ComposableArchitecture
import Core

public struct ForgetState: Equatable {

    public init() {}
}

public enum ForgetAction {}

public struct ForgetEnvironment {

    public init() {}
}

public struct ForgetView: View {

    public typealias ForgetStore = Store<ForgetState, ForgetAction>
    private let store: ForgetStore

    public init(store: ForgetStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Circle()
        }
    }
}

public let forgetReducer = Reducer<ForgetState, ForgetAction, SystemEnvironment<ForgetEnvironment>> { _, _, _ in
    return .none
}
