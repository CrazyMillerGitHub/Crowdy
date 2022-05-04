//
//  EditProfileView.swift
//  
//
//  Created by Mikhail Borisov on 19.04.2022.
//

#if !APPCLIP

import SwiftUI
import ComposableArchitecture
import Core
import DesignSystem

public struct EditProfileView: View {

    private let store: Store<EditProfileState, EditProfileAction>

    public init(store: Store<EditProfileState, EditProfileAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            BottomSheet {
                VStack(spacing: 15) {
                    Slider()
                    InputField(
                        placeholder: StringFactory.AuthFeature.fullName.localizableString,
                        binding: viewStore.binding(\.$fullName)
                    ) {
                        TextField("", text: viewStore.binding(\.$fullName))
                    }
                    InputField(
                        placeholder: StringFactory.AuthFeature.login.localizableString,
                        binding: viewStore.binding(\.$email)
                    ) {
                        TextField("", text: viewStore.binding(\.$email))
                    }
                    Button(StringFactory.EditProfile.saveChanges.localizableString) {
                        viewStore.send(.saveChangesTapped)
                    }
                    .alert(store.scope(state: \.alert), dismiss: .alertOkTapped)
                    .padding(.vertical)
                    .buttonStyle(BrandButtonStyle())
                    .disabled(!viewStore.requestReady)
                    .opacity(viewStore.requestReady ? 1 : 0.5)
                    .animation(.easeOut, value: viewStore.state)
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

public enum EditProfileAction: BindableAction {
    case onAppear
    case saveChangesTapped
    case saveFinished
    case showSuccessAlert
    case showFailureAlert
    case alertOkTapped
    case binding(BindingAction<EditProfileState>)
}

public struct EditProfileState: Equatable {

    @BindableState
    var email: String

    var originalEmail: String

    @BindableState
    var fullName: String
    var alert: AlertState<EditProfileAction>?

    var originalFullName: String
    public let id = UUID()

    var requestReady: Bool {
        (!email.isEmpty && email != originalEmail || !fullName.isEmpty && fullName != originalFullName)
        && Predicate.email.evaluate(email)
    }

    public static var initialState = Self(email: "", fullName: "")

    public init(email: String, fullName: String) {
        self.email = email
        self.fullName = fullName
        self.originalEmail = email
        self.originalFullName = fullName
    }

    public static func == (lhs: EditProfileState, rhs: EditProfileState) -> Bool {
        lhs.fullName == rhs.fullName
        && lhs.email == rhs.email
        && lhs.alert?.id == rhs.alert?.id
    }
}

public struct EditProfileDTO {

    let fullName: String
    let email: String
}

public struct EditProfileEnvironment {

    var loadUserRequest: (PersistenceController) -> Effect<EditProfileDTO, StorageError>

    public init(loadUserRequest: @escaping (PersistenceController) -> Effect<EditProfileDTO, StorageError>) {
        self.loadUserRequest = loadUserRequest
    }
}

public typealias EditProfileReducer = Reducer<EditProfileState, EditProfileAction, SystemEnvironment<EditProfileEnvironment>>
public let editProfileReducer = EditProfileReducer { state, action, environment in
    switch action {
    case .onAppear:
        state.originalEmail = "dsgnmike@gmail.com"
        state.email = "dsgnmike@gmail.com"
        state.fullName = "Mikhail Borisov"
        state.originalFullName = "Mikhail Borisov"
    case .saveChangesTapped:
        return Effect(value: .saveFinished)
    case .saveFinished:
        return Effect(value: .showSuccessAlert)
    case .showSuccessAlert:
        state.alert = AlertState(
            title: .init(StringFactory.Alert.done.localizableString),
            message: .init(StringFactory.Alert.dataSuccessfullyUpdated.localizableString),
            dismissButton: .default(.init(StringFactory.Alert.ok.localizableString))
        )
    case .showFailureAlert:
        state.alert = AlertState(
            title: .init(StringFactory.Alert.error.localizableString),
            message: .init(StringFactory.Alert.somethingWentWrong.localizableString),
            dismissButton: .default(.init(StringFactory.Alert.ok.localizableString))
        )
    case _:
        break
    }
    return .none
    
}.binding()

#endif
