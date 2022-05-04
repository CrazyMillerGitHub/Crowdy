//
//  Splash.swift
//  
//
//  Created by Mikhail Borisov on 08.05.2022.
//

import Foundation

import TCACoordinators
import ComposableArchitecture
import SwiftUI
import DesignSystem
import Core

public enum Splash {

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
        case loadUserResult(Result<Bool, Never>)
        case signedIn
        case notSignedIn
    }

    struct Environment {
        
    }

    struct View: SwiftUI.View {

        let store: Store<Splash.State, Splash.Action>

        var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                VStack {
                    Spacer()
                    Group {
                        Text("Crowdy")
                            .font(.system(size: 26, weight: .heavy, design: .default))
                            .foregroundColor(TokenName.brand.color) +
                        Text(" - сборы с человечским лицом 😃")
                            .font(.system(size: 26, weight: .medium, design: .default))
                    }
                    .transition(.opacity.animation(.easeOut))
                    Spacer()
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }

    static let reducer = Reducer<Splash.State, Splash.Action, SystemEnvironment<Splash.Environment>> { state, action, environment in
        switch action {
        case .onAppear:
            return Effect<Bool, Never>(value: false)
                .delay(for: 0.8, scheduler: environment.mainQueue())
                .eraseToEffect()
                .receive(on: environment.mainQueue())
                .catchToEffect()
                .map(Splash.Action.loadUserResult)
        case .loadUserResult(let response):
            guard case .success(let isLogged) = response, isLogged else {
                return Effect(value: .notSignedIn)
            }
            return Effect(value: .signedIn)
        case _:
            break
        }
        return .none
    }
}
