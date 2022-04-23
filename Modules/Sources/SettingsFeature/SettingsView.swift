//
//  SettingsView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

#if !APPCLIP

import SwiftUI
import DesignSystem
import Core
import OperationRow
import ComposableArchitecture

/// Экран настроек
public struct SettingsView: View {

    @Environment(\.colorScheme) var colorScheme

    private let store: Store<SettingsState, SettingsAction>

    /// Инициализация
    /// - Parameter store: хранилище состояния
    public init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
    }

	public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    AvailabilityView(viewStore.isCardAvailable) {
                        CardSection(store: store)
                    }
                    SpendingSection(spentAmount: viewStore.binding(\.$spent))
                    AvailabilityView(viewStore.isOperationsAvailble) {
                        OperationSection(store: store)
                    }
                    Button(StringFactory.Settings.logOut.localizableString) {
                        viewStore.send(.logOutButtonTapped)
                    }
                    .buttonStyle(BrandButtonStyle(color: .brand))
                    .listRowSeparator(.hidden)
                }
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
                .shimmering(active: viewStore.isLoading)
                .disabled(viewStore.isLoading)
                .listStyle(.plain)
                .navigationTitle("👋, Михаил")
                .navigationBarItems(
                    leading:
                        Text(StringFactory.Settings.welcomeBack.localizableString)
                        .font(.body)
                        .foregroundColor(Color(.systemGray)),
                    trailing:
                        Circle()
                        .fill(
                            colorScheme == .light
                            ? .black
                            : .white
                        )
                        .frame(width: 40, height: 40)
                        .overlay(
                            ZStack {
                                Image("chill")
                                .resizable()
                            }
                        )
                        .onTapGesture {
                            viewStore.send(.editButtonTapped)
                        }
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
	}
}

#endif

#if DEBUG
struct SettingsView_Preview: PreviewProvider {

    static var previews: some View {
        SettingsView(
            store: .init(
                initialState: SettingsState(),
                reducer: settingsReducer,
                environment: .dev(
                    environment: .init(
                        loadUserRequest: dummyLoadUserRequest,
                        loadOperationsRequest: dummyLoadUserOperationsRequest
                    )
                )
            )
        )
    }
}
#endif
