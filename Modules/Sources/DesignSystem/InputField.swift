//
//  InputField.swift
//  
//
//  Created by Mikhail Borisov on 06.03.2022.
//

import SwiftUI

/// Поле ввода
public struct InputField: View {

	// MARK: - Properties

	private let placeholder: String
	@Binding
	private var text: String
	@State
	private var inputFieldHighlighted = false

	private enum Constants {

		static let highlighted: Double = 6
		static let height: Double = 64
		static let lineWidth: Double = 1
		static let cornerRadius: Double = 10
		static let animationDuration: Double = 0.2

		enum Placeholder {
			static let highlightedScale: Double = 0.7
			static let normal: Double = 0
			static let normalScale: Double = 1
			static let verticalOffset: Double = -20
		}
	}

	/// Инициализация
	/// - Parameters:
	///   - placeholder: заголовок плейсхолдера
	///   - text: текст
	public init(_ placeholder: String = "", text: Binding<String>) {
		self._text = text
		self.placeholder = placeholder
	}

	// MARK: - UI

	public var body: some View {
		ZStack(alignment: .leading) {
			Text(placeholder)
				.foregroundColor(
					inputFieldHighlighted
					? Color.brand.color
					: Color.darkSpace.color
				)
				.scaleEffect(
					inputFieldHighlighted
					? Constants.Placeholder.highlightedScale
					: Constants.Placeholder.normalScale,
					anchor: .leading
				)
				.offset(
					y: inputFieldHighlighted
					? Constants.Placeholder.verticalOffset
					: Constants.Placeholder.normal
				)
				.animation(.easeOut(duration: Constants.animationDuration), value: inputFieldHighlighted)
			TextField("", text: $text) { isBegin in
				inputFieldHighlighted = isBegin || !text.isEmpty
            }
            .foregroundColor(SwiftUI.Color.black)
		}
		.offset(x: .zero, y: inputFieldHighlighted ? Constants.highlighted : .zero)
		.padding(.leading)
		.frame(height: Constants.height)
		.overlay(
			RoundedRectangle(cornerRadius: Constants.cornerRadius)
				.stroke(
					inputFieldHighlighted
					? Color.brand.color
					: Color.darkSpace.color,
					lineWidth: Constants.lineWidth
				)
        ).background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.white.color)
        )
	}
}

struct preview_InputField: PreviewProvider {

	@State static var value: String = ""

	static var previews: some View {
		VStack {
			InputField("Имя", text: $value)
				.padding()
			Spacer()
		}
	}
}
