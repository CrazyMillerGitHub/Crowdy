//
//  NewsModel.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import Foundation

struct NewsModel: Decodable, Equatable {

	let identifier: UUID
	let title: String
	let subtitle: String
	let url: URL

	static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}

extension NewsModel: Identifiable {
	var id: UUID { identifier }
}
