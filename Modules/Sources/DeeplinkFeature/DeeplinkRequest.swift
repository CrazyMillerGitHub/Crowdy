//
//  DeeplinkRequest.swift
//  
//
//  Created by Mikhail Borisov on 07.01.2022.
//

#if !APPCLIP

import Parsing
import Foundation

public struct DeepLinkRequest {
	var pathComponents: ArraySlice<Substring>
	var queryItems: [String: ArraySlice<Substring?>]
}

extension DeepLinkRequest {

	public init(url: URL) {
		let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []

		self.init(
			pathComponents: url.path.split(separator: "/")[...],
			queryItems: queryItems.reduce(into: [:]) { dictionary, item in
				dictionary[item.name, default: []].append(item.value?[...])
			}
		)
	}
}

#endif
