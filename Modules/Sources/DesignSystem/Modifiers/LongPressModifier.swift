//
//  LongPressModifier.swift
//  
//
//  Created by Mikhail Borisov on 10.01.2022.
//

import SwiftUI

public struct LongPressModifier: ViewModifier {

	public init() {}

	@GestureState var isPressed: Bool = false

	public func body(content: Content) -> some View {
		content
			.scaleEffect(isPressed ? 0.95 : 1)
			.animation(.easeOut, value: isPressed)
			.gesture(
				LongPressGesture(minimumDuration: 0.5)
					.updating($isPressed) { currentState, gestureState, transaction in
						gestureState = currentState
					}
			)
	}
}
