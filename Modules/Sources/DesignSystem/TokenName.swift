//
//  TokenName.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import UIKit
import SwiftUI

public enum TokenName: String, CaseIterable {

	private typealias RGB = (red: Double, green: Double, blue: Double, alpha: Double)

	case info
	case critical
    case background1
    case background1Inverse
    case background2
    case background2Constant
    case accept
    case brand
    case systemInverse

	public var uiColor: UIColor {
        UIColor(color)
	}

	public var color: SwiftUI.Color {
        Color(rawValue)
	}
}
