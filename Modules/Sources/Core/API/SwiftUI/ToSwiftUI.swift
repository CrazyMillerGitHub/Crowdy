//
//  ToSwiftUI.swift
//  
//
//  Created by Mikhail Borisov on 09.01.2022.
//

#if !APPCLIP

import SwiftUI
import UIKit

public struct ToSwiftUI: UIViewRepresentable {

	public typealias UIViewType = UIView
	private let viewController: () -> UIViewType

	public init(_ viewController: @escaping () -> UIViewType) {
		self.viewController = viewController
	}

    public func makeUIView(context: Context) -> UIView {
        return viewController()
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}

#endif
