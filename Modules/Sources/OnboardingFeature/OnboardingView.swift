//
//  OnboardingView.swift
//  
//
//  Created by Mikhail Borisov on 03.04.2022.
//

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

public enum OnboardingAction {
    case onAppear
    case onDisappear
    case loginTapped
    case registerTapped
}

public struct OnboardingState: Equatable {

    public init() {}
}

public struct OnboardingEnvironment {

    public init() {}
}

public typealias OnboardingReducder = Reducer<OnboardingState, OnboardingAction, OnboardingEnvironment>

public let onboardingReducer = OnboardingReducder { _, _, _ in
    return .none
}

public struct OnboardingView: View {

    private let store: Store<OnboardingState, OnboardingAction>

    public init(store: Store<OnboardingState, OnboardingAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                HStack {
                    Button(StringFactory.Onboarding.logIn.localizableString) {
                        viewStore.send(.loginTapped)
                    }
                    .buttonStyle(BrandButtonStyle(color: .darkContent))
                    Button(StringFactory.Onboarding.register.localizableString) {
                        viewStore.send(.registerTapped)
                    }
                    .buttonStyle(BrandButtonStyle())
                }.padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#if DEBUG
public struct OnboardingView_Preview: PreviewProvider {

    public static var previews: some View {
        OnboardingView(store:
                .init(
                    initialState: .init(),
                    reducer: onboardingReducer,
                    environment: OnboardingEnvironment()
                )
        )
    }
}
#endif
