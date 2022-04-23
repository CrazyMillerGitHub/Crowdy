//
//  OnboardingView.swift
//  
//
//  Created by Mikhail Borisov on 03.04.2022.
//

#if !APPCLIP

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

public enum OnboardingAction: BindableAction {
    case onAppear
    case onDisappear
    case loginTapped
    case registerTapped
    case binding(BindingAction<OnboardingState>)
}

public struct OnboardingState: Equatable {

    @BindableState
    public var showRegister: Bool

    @BindableState
    public var isLoading: Bool

    public static var initialState = Self(showRegister: true, isLoading: true)

    public init(showRegister: Bool, isLoading: Bool) {
        self.showRegister = showRegister
        self.isLoading = isLoading
    }
}

public struct OnboardingEnvironment {

    public init() {}
}

public typealias OnboardingReducder = Reducer<OnboardingState, OnboardingAction, SystemEnvironment<OnboardingEnvironment>>

public let onboardingReducer = OnboardingReducder { store, action, environment in
    switch action {
    case .onAppear:
        store.showRegister = environment.featureAvailability().isRegistrationAvailable
        store.isLoading = false
    default:
        break
    }
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
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Crowdy")
                            .font(.title)
                            .bold()
                        Text("Больше чем сборы")
                            .font(.title2)
                    }
                    Spacer()
                }
                LottieView(name: "onboarding", loopMode: .autoReverse)
                Spacer()
                HStack {
                    Button(StringFactory.Onboarding.logIn.localizableString) {
                        viewStore.send(.loginTapped)
                    }
                    .buttonStyle(BrandButtonStyle(color: .darkContent))
                    AvailabilityView(viewStore.showRegister) {
                        Button(StringFactory.Onboarding.register.localizableString) {
                            viewStore.send(.registerTapped)
                        }
                        .buttonStyle(BrandButtonStyle())
                        .redacted(reason: viewStore.isLoading ? .placeholder : [])
                        .shimmering(active: viewStore.isLoading)
                    }
                }
            }
            .padding()
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#endif

#if DEBUG
public struct OnboardingView_Preview: PreviewProvider {

    public static var previews: some View {
        OnboardingView(store:
                .init(
                    initialState: .initialState,
                    reducer: onboardingReducer,
                    environment: .dev(environment: OnboardingEnvironment())
                )
        )
    }
}
#endif
