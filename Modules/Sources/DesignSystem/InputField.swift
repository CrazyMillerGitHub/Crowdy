//
//  InputField.swift
//  
//
//  Created by Mikhail Borisov on 06.03.2022.
//

import SwiftUI

private enum Constants {

    static let highlighted: Double = 6
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
    private var height: Double
    private let placeholder: String

	@Binding private var binding: String
    private var inputFieldHighlighted: Bool { !binding.isEmpty || isFocused }
    @FocusState private var isFocused: Bool

    public init(
        placeholder: String = "",
        height: CGFloat = 54,
        binding: Binding<String>,
        @ViewBuilder content: () -> Content
    ) {
        self.placeholder = placeholder
        self.height = height
        self.content = content()
        self._binding = binding
    }

	// MARK: - UI

	public var body: some View {
        return ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(
                    TokenName.background2Constant.color
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
            content
                .focused($isFocused)
                .foregroundColor(TokenName.systemInverse.color)
		}
		.offset(x: .zero, y: inputFieldHighlighted ? Constants.highlighted : .zero)
		.padding(.leading)
		.frame(height: height)
		.overlay(
			RoundedRectangle(cornerRadius: Constants.cornerRadius)
				.stroke(
					inputFieldHighlighted
					? TokenName.brand.color
                    : .clear,
					lineWidth: Constants.lineWidth
				)
        )
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(TokenName.background1.color)
        )
	}
}

#if DEBUG
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
#endif
