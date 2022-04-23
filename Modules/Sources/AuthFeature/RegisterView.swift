//
//  RegisterView.swift
//  
//
//  Created by Mikhail Borisov on 03.04.2022.
//

#if !APPCLIP

import DesignSystem
import SwiftUI
import Core
import ComposableArchitecture

public struct RegisterView: View {

    private enum Field {
        case fullName
        case login
        case password
        case confirrmPassword
    }

    let store: Store<AuthState, AuthAction>
    @FocusState private var focusedField: Field?

    public var body: some View {
        return WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                Text("Зарегистрируйтесь в Crowdy")
                    .bold()
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical)
                InputField(
                    placeholder: StringFactory.AuthFeature.fullName.localizableString,
                    binding: viewStore.binding(\.$fullNameValue)
                ) {
                    TextField("", text: viewStore.binding(\.$fullNameValue))
                        .focused($focusedField, equals: .fullName)
                }
                InputField(
                    placeholder: StringFactory.AuthFeature.login.localizableString,
                    binding: viewStore.binding(\.$loginValue)
                ) {
                    TextField("", text: viewStore.binding(\.$loginValue))
                        .focused($focusedField, equals: .login)
                }
                InputField(
                    placeholder: StringFactory.AuthFeature.password.localizableString,
                    binding: viewStore.binding(\.$passwordValue)
                ) {
                    SecureField("", text: viewStore.binding(\.$passwordValue))
                        .focused($focusedField, equals: .password)
                }
                AvailabilityView(!viewStore.passwordValue.isEmpty) {
                    InputField(
                        placeholder: StringFactory.AuthFeature.confirmPassword.localizableString,
                        binding: viewStore.binding(\.$confirmPasswordValue)
                    ) {
                        SecureField("", text: viewStore.binding(\.$confirmPasswordValue))
                            .focused($focusedField, equals: .confirrmPassword)
                    }
                }
                Text(StringFactory.AuthFeature.areYouRegistered.localizableString)
                    .font(.footnote)
                    .bold()
                    .foregroundColor(Color.brand.color)
                    .onTapGesture {
                        viewStore.send(.areYouRegisteredTapped)
                    }
                Spacer()
                Button(StringFactory.AuthFeature.register.localizableString) {
                    viewStore.send(.registerButtonTapped)
                }
                .buttonStyle(BrandButtonStyle())
            }
            .overlay(content: {
                ProgressView()
                    .opacity(viewStore.isLoading ? 1 : 0)
            })
            .padding([.leading, .trailing])
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
            .onSubmit {
                switch focusedField {
                case .fullName:
                    focusedField = .login
                case .login:
                    focusedField = .password
                case .password:
                    focusedField = .confirrmPassword
                case _:
                    return
                }
            }
        }
    }
}

#endif
