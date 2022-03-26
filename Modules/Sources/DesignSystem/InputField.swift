//
//  InputField.swift
//  
//
//  Created by Mikhail Borisov on 06.03.2022.
//

import SwiftUI

private enum Constants {

    static let highlighted: Double = 6
    static let height: Double = 54
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

/// Поле ввода
public struct InputField<Content: View>: View {

	// MARK: - Properties
    private let content: Content
    private let placeholder: String

    @Environment(\.colorScheme) var colorScheme
	@Binding private var binding: String
    private var inputFieldHighlighted: Bool { !binding.isEmpty || isFocused }
    @FocusState private var isFocused: Bool

    public init(
        placeholder: String = "",
        binding: Binding<String>,
        @ViewBuilder content: () -> Content
    ) {
        self.placeholder = placeholder
        self.content = content()
        self._binding = binding
    }

	// MARK: - UI

	public var body: some View {
		return ZStack(alignment: .leading) {
			Text(placeholder)
				.foregroundColor(
                    Color.lightContent.color
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
				.animation(
                    .easeOut(duration: Constants.animationDuration),
                    value: inputFieldHighlighted
                )
            content
                .focused($isFocused)
            .foregroundColor(colorScheme == .dark ? .white : .black)
		}
		.offset(x: .zero, y: inputFieldHighlighted ? Constants.highlighted : .zero)
		.padding(.leading)
		.frame(height: Constants.height)
		.overlay(
			RoundedRectangle(cornerRadius: Constants.cornerRadius)
				.stroke(
					inputFieldHighlighted
					? Color.brand.color
                    : .clear,
					lineWidth: Constants.lineWidth
				)
        ).background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(colorScheme == .dark ? Color.darkContent.color : .black.opacity(0.1))
        )
	}
}

struct Preview_InputField: PreviewProvider {

	@State
    static var value: String = ""

	static var previews: some View {
		VStack {
            InputField(placeholder: "Name", binding: $value, content: {
                SecureField("", text: $value)
            })
				.padding()
			Spacer()
		}
	}
}
