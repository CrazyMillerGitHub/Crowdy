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

public struct ForgetState: Equatable {

    @BindableState
    public var email: String

    public static var initialState = Self(email: "")

    public init(email: String) {
        self.email = email
    }
}

public enum ForgetAction: BindableAction {
    case sendRequestTapped
    case binding(BindingAction<ForgetState>)
}

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
            VStack {
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
                .buttonStyle(BrandButtonStyle())
            }
            .padding()
            .navigationTitle(StringFactory.Forget.passwordReset.localizableString)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

public let forgetReducer = Reducer<ForgetState, ForgetAction, SystemEnvironment<ForgetEnvironment>> { _, _, _ in
    return .none
}.binding()

#endif
