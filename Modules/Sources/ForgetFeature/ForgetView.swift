//
//  ForgetView.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//
#if !APPCLIP

import SwiftUI
import ComposableArchitecture
import Core
import DesignSystem

public struct ForgetView: View {

    public typealias ForgetStore = Store<ForgetState, ForgetAction>

    private let store: ForgetStore

    public init(store: ForgetStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                InputField(
                    placeholder: StringFactory.Forget.login.localizableString,
                    binding: viewStore.binding(\.$email)
                ) {
                    TextField("", text: viewStore.binding(\.$email))
                }
                Spacer()
                Button(StringFactory.Forget.sendRequest.localizableString) {
                    viewStore.send(.sendRequestTapped)
                }
                .buttonStyle(BrandButtonStyle(color: .brand))
                .disabled(!viewStore.requestIsReady)
                .opacity(viewStore.requestIsReady ? 1 : 0.5)
                .animation(.easeOut, value: viewStore.state)
            }
            .padding()
            .alert(store.scope(state: \.alert), dismiss: .alertOkTapped)
            .navigationTitle(StringFactory.Forget.passwordReset.localizableString)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

public typealias ForgetReducer = Reducer<ForgetState, ForgetAction, SystemEnvironment<ForgetEnvironment>>

public let forgetReducer = ForgetReducer { state, action, environment in
    switch action {
    case .sendRequestTapped:
        state.alert = .init(title: .init("Запрос успешно отправлен"), buttons: [])
    case .alertOkTapped:
        state.alert = nil
    case _:
        break
    }
    return .none
}

#endif
