//
//  TopTrailingViewModifier.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI

public struct TopTrailingViewModifier: ViewModifier {

	public init() {}

	public func body(content: Content) -> some View {
		VStack {
			HStack {
				Spacer()
				content
			}
			Spacer()
		}
	}
}
