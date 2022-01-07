//
//  QueryItem.swift
//  
//
//  Created by 18673799 on 07.01.2022.
//

import Foundation
import Parsing

public struct PathEnd: Parser {

	public init() {}

	public func parse(_ input: inout DeepLinkRequest) -> Void? {
		guard input.pathComponents.isEmpty
		else { return nil }
		return ()
	}
}

public struct QueryItem<ValueParser>: Parser where ValueParser: Parser, ValueParser.Input == Substring {

	let name: String
	let valueParser: ValueParser

	public init(_ name: String, _ valueParser: ValueParser) {
		self.name = name
		self.valueParser = valueParser
	}

	public init(_ name: String) where ValueParser == Rest<Substring> {
		self.init(name, Rest())
	}

	public func parse(_ input: inout DeepLinkRequest) -> ValueParser.Output? {
		guard
			let wrapped = input.queryItems[self.name]?.first,
			var value = wrapped,
			let output = self.valueParser.parse(&value),
			value.isEmpty
		else { return nil }

		input.queryItems[self.name]?.removeFirst()
		return output
	}
}
