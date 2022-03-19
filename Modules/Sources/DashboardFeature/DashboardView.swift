//
//  SearchView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import DesignSystem
import ComposableArchitecture

public struct DashboardView: View {

    private let store: Store<DashboardState, DashboardAction>

    public init(store: Store<DashboardState, DashboardAction>) {
        self.store = store
    }

	public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    Section(header: Text("Активные сборы")) {
                        ForEach(viewStore.state.activateFunds, id: \.id) { fund in
                            DashboardRow(viewStore: viewStore)
                        }
                    }
                    .listSectionSeparator(.hidden)
                    Section(header: Text("Прошедшие сборы")) {
                        ForEach(viewStore.state.previousFunds, id: \.id) { fund in
                            DashboardRow(viewStore: viewStore)
                        }
                    }
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationTitle(StringFactory.Tab.dashboard.localizableString)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
	}
}
