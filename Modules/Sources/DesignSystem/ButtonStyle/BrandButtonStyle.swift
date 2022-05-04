//
//  BrandButtonStyle.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import SwiftUI

public struct BrandButtonStyle: ButtonStyle {

	private struct Constants {
		static let cornerRadius: CGFloat = 10
	}

	private let color: TokenName

    private var isInverseToken: Bool {
        return [.systemInverse, .background1Inverse].contains(color)
    }

    public init(color: TokenName = .brand) {
		self.color = color
	}

	public func makeBody(configuration: Configuration) -> some View {
		configuration
			.label
			.font(Font.button.font)
			.frame(minWidth: .zero, maxWidth: .infinity)
			.frame(height: 60)
			.background(color.color)
            .foregroundColor(isInverseToken ? TokenName.background1.color : .white)
			.cornerRadius(Constants.cornerRadius)
			.scaleEffect(configuration.isPressed ? 0.9 : 1.0)
			.animation(Animation.easeOut, value: configuration.isPressed)
			.padding(.bottom)
	}
}
