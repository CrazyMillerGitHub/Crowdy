//
//  RowModifier.swift
//  
//
//  Created by Mikhail Borisov on 10.01.2022.
//

import SwiftUI

public struct RowModifier: ViewModifier {

    @Environment(\.colorScheme) var colorScheme
	private let cornerRadius: CGFloat

	public init(cornerRadius: CGFloat = 15) {
		self.cornerRadius = cornerRadius
	}

	public func body(content: Content) -> some View {
		content
			.cornerRadius(cornerRadius)
			.listRowBackground(SwiftUI.Color.clear)
			.listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            .background(colorScheme == .dark ? Color.darkContent.color : .white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.10), radius: 5, x: 0, y: 0)
	}
}
