//
//  HomeView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

#if !APPCLIP

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

public struct HomeView: View {

	private let store: Store<HomeState, HomeAction>

	public init(store: Store<HomeState, HomeAction>) {
		self.store = store
	}

    public var body: some View {
        WithViewStore(store) { viewStore in
            HomeList(store: store)
                .navigationBarTitle(StringFactory.Tab.discovery.localizableString, displayMode: .large)
                .searchable(
                    text: viewStore.binding(\.$searchText),
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Поиск"
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .onTapGesture {
                                viewStore.send(.addTapped)
                            }
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
	}
}

public struct HomeList: View {

    private let store: Store<HomeState, HomeAction>

    init(store: Store<HomeState, HomeAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                LazyVStack {
                    ForEach(viewStore.searchResults, id: \.id) { fund in
                        HomeRow(store: store, fund: fund)
                            .padding()
                            .redacted(reason: !viewStore.isLoading ? [] : .placeholder)
                            .shimmering(active:  viewStore.isLoading)
                    }.transition(.opacity.animation(.default))
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#endif
