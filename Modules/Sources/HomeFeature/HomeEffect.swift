//
//  HomeEffect.swift
//  
//
//  Created by Mikhail Borisov on 10.01.2022.
//

import Foundation
import ComposableArchitecture
import Core

func homeRowsEffect(decoder: JSONDecoder) -> Effect<[Int], APIError> {
	guard let url = URL(string: "es.com/apo") else {
		return Effect(error: .urlError)
	}
	return URLSession.shared.dataTaskPublisher(for: url)
		.mapError { _ in APIError.downloadError }
		.map { data, _ in data }
		.decode(type: [Int].self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func dummHomeRowsEffect(decoder: JSONDecoder) -> Effect<[Int], APIError> {
	return Effect(value: [1, 2, 3, 4, 5])
}
