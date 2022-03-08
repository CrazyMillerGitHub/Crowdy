//
//  HomeRowModel.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import Foundation

public struct HomeRowModel: Decodable, Equatable {
	/// Идентификатор
	let identifier: UUID
	/// Заголовок
	let title: String
	/// Описание
	let subtitle: String
	/// Ссылка на медиаобъект
	let mediaUrl: URL?
	/// Является ли избранным
	var favourite: Bool
	/// Дата истечения
	let expirationDate: Double
	/// Начальная сумма
	let originalAmount: Double
	/// Оставшаяся сумма
	let remainAmount: Double
	/// Кол-во участников
	let participantsCount: Int

	public static var fixture: HomeRowModel {
		return Self.init(
			identifier: .init(),
			title: "",
			subtitle: "",
			mediaUrl: nil,
			favourite: false,
			expirationDate: .zero,
			originalAmount: .zero,
			remainAmount: .zero,
			participantsCount: .zero
		)
	}

	public var amountPrecentage: Double {
		return (originalAmount - remainAmount) / originalAmount
	}
}

extension HomeRowModel: Identifiable {

	public var id: UUID { identifier }
}
