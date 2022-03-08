//
//  SearchView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import DesignSystem

public struct DashboardView: View {

	public init() {}

	public var body: some View {
		NavigationView {
			VStack {
				Spacer()
				VStack {
					AlertView(title: "Terrible sorry", subtitle: "No active funds", imageName: "chill")
				}
				Spacer()
			}.navigationTitle("Dashboard")
		}
	}
}
