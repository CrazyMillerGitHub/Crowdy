//
//  RootView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import HomeFeature
import SearchFeature
import SettingsFeature
import Foundation

public struct RootView: View {

	public init() {}

	public var body: some View {
		TabView {
			HomeView()
				.tabItem {
					Image(systemName: "list.bullet")
					Text("Repositories")
				}
			SearchView()
				.tabItem {
					Image(systemName: "list.bullet")
					Text("Repositories")
				}
			SettingsView()
				.tabItem {
					Image(systemName: "list.bullet")
					Text("Repositories")
				}
		}
	}
}

#if DEBUG
struct RootView_Preview: PreviewProvider {

	static var previews: some View {
		RootView()
	}
}
#endif
