//
//  BrandButtonStyle.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import SwiftUI

public struct BrandButtonStyle: ButtonStyle {

	private struct Constants {
		static let cornerRadius: CGFloat = 15
		static let horizontalPadding: CGFloat = 60
	}

	public init() {}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(Font.button.font)
			.frame(minWidth: .zero, maxWidth: .infinity)
			.padding()
			.foregroundColor(.white)
			.background(Color.blue.color)
			.cornerRadius(Constants.cornerRadius)
			.padding(.horizontal, Constants.horizontalPadding)
			.scaleEffect(configuration.isPressed ? 0.9 : 1.0)
			.animation(Animation.easeOut)
	}
}
