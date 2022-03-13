//
//  HomeView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import HomeRow
import ComposableArchitecture
import DesignSystem
import DetailFeature

public struct HomeView: View {

	private let store: Store<HomeState, HomeAction>

	public init(store: Store<HomeState, HomeAction>) {
		self.store = store
	}

	public var body: some View {
		WithViewStore(store) { viewStore in
			NavigationView {
                VStack {
                    Picker("", selection: viewStore.state.$selectionState) {
                        Text("Funds").tag(SelectionState.funds)
                        Text("Charity").tag(SelectionState.charity)
                    }
                    .pickerStyle(.segmented)
                    Form {
                        NavigationLink {
                        } label: {
                            HomeRow(store: .init(
                                initialState: viewStore.state.homeRowState,
                                reducer: homeRowReducer,
                                environment: .dev(
                                    environment: HomeRowEnvironment(
                                        crowdfundingId: { 4 },
                                        crowdfundingRequest: dummyCrowdfundingEffect,
                                        mediaContentRequest: dummyMediaContentEffect,
                                        updateFavouriteRequest: dummyUpdateFavouriteEffect
                                    )
                                )
                            )
                            )
                        }
                    }
                }
                .navigationTitle(StringFactory.Tab.discovery.localizableString)
			}
		}
	}
}
