//
//  HomeView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

public struct HomeView: View {

	private let store: Store<HomeState, HomeAction>
    @State
    private var searchText = ""

	public init(store: Store<HomeState, HomeAction>) {
		self.store = store
	}
    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                LazyVStack {
                    ForEach(viewStore.funds, id: \.id) { fund in
                        HomeRow(viewStore: viewStore, fund: fund)
                            .padding()
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "plus")
                        .font(.body)
                        .onTapGesture {
                            viewStore.send(.addTapped)
                        }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle(StringFactory.Tab.discovery.localizableString)
	}
}
