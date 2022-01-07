//
//  Color.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import UIKit
import SwiftUI

public enum Color: CaseIterable {

	private typealias RGB = (red: Double, green: Double, blue: Double, alpha: Double)

	case blue
	case magnetta
	case darkSpace
	case white

	public var uiColor: UIColor {
		.init(red: rgbPalette.red, green: rgbPalette.green, blue: rgbPalette.blue, alpha: rgbPalette.alpha)
	}

	public var color: SwiftUI.Color {
		.init(red: rgbPalette.red, green: rgbPalette.green, blue: rgbPalette.blue)
	}

	private var rgbPalette: RGB {
		switch self {
		case .blue:
			return (red: 0/256, green: 91/256, blue: 255/256, alpha: 1.0)
		case .magnetta:
			return (red: 249/256, green: 17/256, blue: 85/256, alpha: 1.0)
		case .darkSpace:
			return (red: 0/256, green: 26/256, blue: 52/256, alpha: 1.0)
		case .white:
			return (red: 1, green: 1, blue: 1, alpha: 1.0)
		}
	}
}
