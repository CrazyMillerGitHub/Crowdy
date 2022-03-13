//
//  SettingsView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import DesignSystem
import Core
import ResizableSheet
import OperationRow
import ComposableArchitecture

/// Экран настроек
public struct SettingsView: View {

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
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.brand.color)
                            .frame(height: 164)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "plus.square")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .listRowSeparator(.hidden)
                    Section(header: Text(StringFactory.Settings.spent.localizableString)) {
                        Text("123 $")
                            .font(.system(size: 25, weight: .semibold))
                            .listRowSeparator(.hidden)
                    }
                    Section {
                        ForEach(0 ..< 3) {_ in
                            OperationRow(model: .fixture)
                        }.listRowSeparator(.hidden)
                    } header: {
                        Text(StringFactory.Settings.recentCrowdfundings.localizableString)
                    } footer: {
                        Button(StringFactory.Settings.logOut.localizableString) {
                            viewStore.send(.logOutButtonTapped)
                        }
                        .buttonStyle(BrandButtonStyle(color: .brand))
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("👋, Mikhail")
                .navigationBarItems(
                    leading:
                        Text(StringFactory.Settings.welcomeBack.localizableString)
                        .font(.body)
                        .foregroundColor(Color(.systemGray)),
                    trailing:
                       Image("chill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
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

struct SettingsView_Preview: PreviewProvider {

    static var previews: some View {
        SettingsView(
            store: .init(
                initialState: SettingsState(),
                reducer: settingsReducer,
                environment: .dev(
                    environment: .init(loadUserRequest: dummyLoadUserRequest)
                )
            )
        )
    }
}
