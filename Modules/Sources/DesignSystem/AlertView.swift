//
//  AlertView.swift
//  
//
//  Created by Mikhail Borisov on 31.01.2022.
//

import SwiftUI

/// Алерт
public struct AlertView: View {

	/// Заголовок алерта
	let title: String
	/// Описания алерта
	let subtitle: String
	/// Название изображения
	let imageName: String

	/// Инициализация
	/// - Parameters:
	///   - title: заголовок
	///   - subtitle: подзаголовок
	///   - imageName: название изображения
	public init(
		title: String,
		subtitle: String,
		imageName: String
	) {
		self.title = title
		self.subtitle = subtitle
		self.imageName = imageName
	}

	public var body: some View {
		VStack {
			Image(imageName, bundle: .main)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 128, height: 128)
			Text(title)
                .foregroundColor(TokenName.background2.color)
				.font(.system(size: 17, weight: .semibold))
			Text(subtitle)
                .foregroundColor(TokenName.background2.color)
				.font(.system(size: 15, weight: .regular))
		}
	}
}

#if DEBUG
struct AlertView_Preview: PreviewProvider {

	static var previews: some View {
		AlertView(
			title: "Terrible sorry",
			subtitle: "No active funds",
			imageName: "chill"
		)
	}
}
#endif
