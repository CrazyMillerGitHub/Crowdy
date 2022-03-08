//
//  SettingsView.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import DesignSystem

public struct SettingsView: View {

	public init() {}

	public var body: some View {
		NavigationView {
			ZStack {
				ScrollView {
					
				}
				VStack {
					Spacer()
					Button("Выйти") {
						print("Hello world")
					}
                    .padding([.leading, .trailing])
					.buttonStyle(BrandButtonStyle(color: .brand))
					.padding(.bottom)
				}
			}
			.navigationTitle("👋, Mikhail")
			.navigationBarItems(
				leading:
				Text("С возвращением")
					.font(.body)
					.foregroundColor(Color(.systemGray)),
				trailing:
				   Image("chill")
					   .resizable()
					   .frame(width: 40, height: 40)
					   .clipShape(Circle())
			)
		}
	}
}

struct SettingsView_Preview: PreviewProvider {

	static var previews: some View {
		SettingsView()
	}
}
