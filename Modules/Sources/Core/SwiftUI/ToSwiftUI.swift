//
//  ToSwiftUI.swift
//  
//
//  Created by Mikhail Borisov on 09.01.2022.
//

import SwiftUI
import UIKit

public struct ToSwiftUI: UIViewControllerRepresentable {

	public typealias UIViewControllerType = UIViewController
	private let viewController: () -> UIViewController

	public init(_ viewController: @escaping () -> UIViewController) {
		self.viewController = viewController
	}

	public func makeUIViewController(context: Context) -> UIViewController {
		return viewController()
	}
	
	public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
