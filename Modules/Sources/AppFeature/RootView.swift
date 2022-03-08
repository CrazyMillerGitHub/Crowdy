//
//  RootView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import HomeFeature
import Core
import DashboardFeature
import SettingsFeature
import AuthFeature
import Foundation
import ComposableArchitecture

public struct RootView: View {

	private let store: Store<RootState, RootAction>

	public init(store: Store<RootState, RootAction>) {
		self.store = store
	}

	public var body: some View {
		WithViewStore(store.stateless) { viewStore in
			TabView {
				HomeView(
					store: .init(
						initialState: .init(homeRowState: .init()),
						reducer: homeReducer,
						environment: .dev(environment: .init())
					)
				)
					.tabItem {
						Image(systemName: "star.square.fill")
						Text("Discovery")
					}
				DashboardView()
					.tabItem {
						Image(systemName: "chart.bar.fill")
						Text("Dashboard")
					}
				SettingsView()
					.tabItem {
						Image(systemName: "gearshape.fill")
						Text("Settings")
					}
			}
		}
	}
}

#if DEBUG
struct RootView_Preview: PreviewProvider {

	static var previews: some View {
		RootView(
			store: .init(
				initialState: RootState(),
				reducer: rootReducer,
				environment: .dev(environment: RootEnvironment())
			)
		)
	}
}
#endif
