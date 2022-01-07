//
//  PathComponent.swift
//  
//
//  Created by 18673799 on 07.01.2022.
//

import Foundation
import Parsing

public struct PathComponent<ComponentParser>: Parser where ComponentParser: Parser, ComponentParser.Input == Substring {

	let component: ComponentParser

	public init(_ component: ComponentParser) {
		self.component = component
	}

	public func parse(_ input: inout DeepLinkRequest) -> ComponentParser.Output? {
		guard
			var firstComponent = input.pathComponents.first,
			let output = self.component.parse(&firstComponent),
			firstComponent.isEmpty
		else { return nil }
		input.pathComponents.removeFirst()
		return output
	}
}
