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
            List {
                Section(header: Text("Вы - собиратель")) {
                    ForEach(0..<3) { _ in
                        Text("33")
                    }
                }
                Section(header: Text("Вы - жертвователь")) {
                    ForEach(0..<3) { _ in
                        Text("33")
                    }
                }
            }
//			VStack {
//				Spacer()
//				VStack {
//					AlertView(title: "Terrible sorry", subtitle: "No active funds", imageName: "chill")
//				}
//				Spacer()
            .navigationTitle(StringFactory.Tab.dashboard.localizableString)
		}
	}
}
