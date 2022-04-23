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
                    HStack() {
                        Spacer()
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.gray.opacity(0.7))
                            .frame(width: 35, height: 4)
                        Spacer()
                    }
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
                        print("")
                    }
                    .padding(.vertical)
                    .buttonStyle(BrandButtonStyle())
                }
            }
        }
    }
}

public enum EditProfileAction: BindableAction {

    case binding(BindingAction<EditProfileState>)
}

public struct EditProfileState: Equatable {

    @BindableState
    var email: String

    var originalEmail: String

    @BindableState
    var fullName: String

    var originalFullName: String

    public static var initialState = Self(email: "example.email", fullName: "Example full Name")

    public init(email: String, fullName: String) {
        self.email = email
        self.fullName = fullName
        self.originalEmail = email
        self.originalFullName = fullName
    }
}

public struct EditProfileEnvironment {

    public init() {}
}

public let editProfileReducer = Reducer<EditProfileState, EditProfileAction, SystemEnvironment<EditProfileEnvironment>> { _, _, _ in
    return .none
}.binding()

#endif
