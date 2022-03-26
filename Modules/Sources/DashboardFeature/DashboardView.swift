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
                    AvailabilityView(!viewStore.state.activateFunds.isEmpty) {
                        Section(header: Text(StringFactory.Dashboard.activeFund.localizableString)) {
                            ForEach(viewStore.state.activateFunds, id: \.id) { fund in
                                DashboardRow(viewStore: viewStore, fund: fund)
                            }
                        }
                        .listSectionSeparator(.hidden)
                    }
                    AvailabilityView(!viewStore.state.previousFunds.isEmpty) {
                        Section(header: Text(StringFactory.Dashboard.previousFund.localizableString)) {
                            ForEach(viewStore.state.previousFunds, id: \.id) { fund in
                                DashboardRow(viewStore: viewStore, fund: fund)
                            }
                        }
                        .listSectionSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(StringFactory.Tab.dashboard.localizableString)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
                .shimmering(active: viewStore.isLoading)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
	}
}
